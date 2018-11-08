use strict;
use warnings;

# HOW TO USE THIS TEST
#
# By default, this test runs over all directories in t/data/plugins/.  To run
# the test only for specific directories, pass the directory names to this
# script or assign them to the environment variable SERGE_PLUGINS_TESTS as a
# comma-separated list.  The following two examples are equivalent:
#
# perl t/enigne.t mojito zanata
# SERGE_PLUGINS_TESTS=mojito,zanata prove t/engine.t

BEGIN {
    use Cwd qw(abs_path);
    use File::Basename;
    use File::Spec::Functions qw(catfile);
    map { unshift(@INC, catfile(dirname(abs_path(__FILE__)), $_)) } qw(lib ../lib);
}

use File::Find qw(find);
use File::Path;
use File::Spec::Functions qw(catfile);
use Getopt::Long;
use Test::More;
use Serge::Interface::SysCmdRunner;
use Serge::Config;
use Test::PluginHost;
use Test::SysCmdRunner;

$| = 1; # disable output buffering

my $sys_cmd_runner;

# as the real command line interfaces cannot be invoked,
# we override the `run_cmd` function;
sub Serge::Interface::SysCmdRunner::run_cmd {
    my ($self, $command, $capture, $ignore_codes) = @_;

    die 'Undefined system command runner' unless $sys_cmd_runner;

    return $sys_cmd_runner->run_cmd($command, $capture, $ignore_codes);
}

sub output_errors {
    my ($error, $errors_path, $filename, $plugin) = @_;

    # cleanup error message to avoid having file paths that will differ across installations
    $error =~ s/\s+$//sg;
    $error =~ s/ at .*? line \d+\.$//s;
    $error =~ s/ \(\@INC contains: .*\)$//s;
    $error =~ s/\@INC.+$/\@INC/s;

    print "Plugin '$plugin' will be skipped: $error\n";

    eval { mkpath($errors_path) };
    die "Couldn't create $errors_path: $@" if $@;
    my $full_filename = catfile('./errors/', $filename);
    open(OUT, ">$full_filename");
    binmode(OUT, ':unix :utf8');
    print OUT $error;
    close(OUT);
}

my $this_dir = dirname(abs_path(__FILE__));

my @confs;

my ($init_commands);

GetOptions("init" => \$init_commands);

my @dirs = @ARGV;
if (my $env_dirs = $ENV{SERGE_PLUGINS_TESTS}) {
    push @dirs, split(/,/, $env_dirs);
}

unless (@dirs) {
    find(sub {
        push @confs, $File::Find::name if(-f $_ && /\.serge$/ && $_ ne 'common.serge');
    }, $this_dir);
} else {
    for my $dir (@dirs) {
        find(sub {
            push @confs, $File::Find::name if(-f $_ && /\.serge$/ && $_ ne 'common.serge');
        }, catfile($this_dir, "data/plugins", $dir));
    }
}

my $plugin_host = Test::PluginHost->new();

for my $config_file (@confs) {

    subtest "Test config: $config_file" => sub {
        my $cfg = Serge::Config->new($config_file);

        SKIP: {
            my $ok = ok(defined $cfg, 'Config file read');

            $cfg->chdir;

            my $ts;
            my $plugin = '';

            eval {
                $plugin = $cfg->{data}->{sync}->{ts}->{plugin};

                $ts = $plugin_host->load_plugin_from_node(
                    'Serge::Sync::Plugin::TranslationService',
                    $cfg->{data}->{sync}->{ts}
                );
            };

            output_errors($@, './errors/', 'new.txt', $plugin) if $@;

            if ($ts) {
                $sys_cmd_runner = Test::SysCmdRunner->new('pull');

                $sys_cmd_runner->{init} = $init_commands;

                $sys_cmd_runner->start();

                my $pull_result = 1;

                eval {
                    $pull_result = $ts->pull_ts();
                };

                output_errors($@, './errors/', 'pull.txt', $plugin) if $@;

                $sys_cmd_runner->stop();

                $ok = ok($pull_result eq 0, "'pull'");

                $sys_cmd_runner = Test::SysCmdRunner->new('push');

                $sys_cmd_runner->{init} = $init_commands;

                $sys_cmd_runner->start();

                my $push_result = 1;

                eval {
                    $push_result = $ts->push_ts();
                };

                output_errors($@, './errors/', 'push.txt', $plugin) if $@;

                $sys_cmd_runner->stop();

                $ok = ok($push_result eq 0, "'push'") and $ok;
            }
        }
    }
}

done_testing();
