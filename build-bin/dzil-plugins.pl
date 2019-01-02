use warnings;
use strict;

use Getopt::Long;
use Template;

Getopt::Long::Configure(qw{no_auto_abbrev no_ignore_case_always});

my @ignore_codes_array = ();
my @plugins = ();
my $command = undef;

GetOptions ("command|c=s" => \$command, "ignore|i=i" => \@ignore_codes_array, "plugins|p=s" => \@plugins);

my $ignore_codes = \@ignore_codes_array;

if (not defined $command) {
    die "command undefined\n";
}

my $template = Template->new || die Template->error(), "\n";

my $plugins_count = scalar @plugins;

if ($plugins_count == 0) {
    @plugins = ();
    my @modules = glob('lib/Serge/Sync/Plugin/TranslationService/*.pm');

    foreach my $module (@modules) {
        my ($module_name) = ($module =~ m/.*\/(.*?)\.pm/);

        if ($module_name) {
            push @plugins, $module_name;
        }
    }
}

foreach my $plugin (@plugins) {
    print "$plugin\n";

    $template->process('dist.ini-plugins', {
	  api_name => $plugin
	},
	'dist.ini') || die $template->error(), "\n";

    my $result = `dzil $command`;

    print $result;

    my $error_code = unpack 'c', pack 'C', $? >> 8; # error code

    if (($error_code != 0) && $ignore_codes && (grep($_ eq $error_code, @ignore_codes_array) > 0)) {
        print "Exit code: $error_code (ignored)\n";
        $error_code = 0;
    }

    die "\nExit code: $error_code; last error: $!\n" if $error_code != 0;
}
