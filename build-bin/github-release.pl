use warnings;
use strict;

use Getopt::Long;
use Template;

Getopt::Long::Configure(qw{no_auto_abbrev no_ignore_case_always});

my @plugins = ();

GetOptions ("plugins|p=s" => \@plugins);

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

    my $version = get_version($plugin);

    my $tag_exists = check_tag_exists($plugin, $version);

    if (not $tag_exists) {
        create_tag(($plugin, $version))
    }

    git_push();
}

sub check_error_code {
    my $error_code = unpack 'c', pack 'C', $? >> 8; # error code

    die "\nExit code: $error_code; last error: $!\n" if $error_code != 0;
}

sub get_tag {
    my ($plugin, $version) = @_;

    return "${plugin}_v${version}";
}

sub git_push {
    my $result = `git push`;

    check_error_code();

    print $result;
}

sub check_tag_exists {
    my ($plugin, $version) = @_;

    my $tag = get_tag($plugin, $version);

    my $tag_check = `git tag -l "$tag"`;

    check_error_code();

    if ($tag_check) {
        print "tag ${tag} already exists";

        return 1;
    }

    print "tag ${tag} does not exists";

    return 0;
}

sub create_tag {
    my ($plugin, $version) = @_;

    my $tag = get_tag($plugin, $version);

    my $result = `git tag -a $tag -m "${plugin} version ${version}"`;

    check_error_code();

    print $result;
}

sub get_version {
    my ($plugin) = @_;

    $template->process('dist.ini-plugins', {
        api_name => $plugin
    },
        'dist.ini') || die $template->error(), "\n";

    my $result = `dzil build`;

    print $result;

    my $error_code = unpack 'c', pack 'C', $? >> 8; # error code

    die "\nExit code: $error_code; last error: $!\n" if $error_code != 0;

    my $full_plugin = "Serge::Sync::Plugin::TranslationService::$plugin";

    print ("$full_plugin\n");

    my $full_version = `perldoc -m "$full_plugin" | grep VERSION`;

    my $version = '';

    if ($full_version =~ /([0-9.]+)/g) {
        $version = $1;
    }

    $full_version =~ s/([0-9.]+)/$1/g;

    return $version;
}
