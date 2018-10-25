use warnings;
use strict;

use Template;

my ($command) = @ARGV;

if (not defined $command) {
  die "command undefined\n";
}

my $template = Template->new;
my @dirs = glob('lib/Serge/Sync/Plugin/TranslationService/*.pm');

foreach my $dir (@dirs) {
  my ($module_name) = ($dir =~ m/.*\/(.*?)\.pm/);
  print "$module_name\n";

  $template->process('dist.ini-plugins', {
      api_name => $module_name
    },
    'dist.ini'
  );

  print `dzil $command`;
}
