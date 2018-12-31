use warnings;
use strict;

use Template;

my ($command) = @ARGV;

if (not defined $command) {
    die "command undefined\n";
}

my $template = Template->new || die Template->error(), "\n";

my @dirs = glob('lib/Serge/Sync/Plugin/TranslationService/*.pm');

foreach my $dir (@dirs) {
    my ($module_name) = ($dir =~ m/.*\/(.*?)\.pm/);

    print "$module_name\n";

    $template->process('dist.ini-plugins', {
	  api_name => $module_name
	},
	'dist.ini') || die $template->error(), "\n";

    my $result = `dzil $command`;

    print $result;

    my $error_code = unpack 'c', pack 'C', $? >> 8; # error code

    die "\nExit code: $error_code; last error: $!\n" if $error_code != 0;
}
