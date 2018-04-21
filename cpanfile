requires 'perl' => '5.010001';
requires 'Serge';

on 'develop' => sub {
  requires 'Template';
  requires 'Pod::HTML2Pod';
  requires 'Dist::Zilla';
  requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
  requires 'Dist::Zilla::Plugin::VersionFromMainModule';
  requires 'Dist::Zilla::PluginBundle::Git';
  requires 'Dist::Zilla::Plugin::UploadToCPAN';
  requires 'Dist::Zilla::Plugin::RunExtraTests';
  requires 'Dist::Zilla::Plugin::Test::Compile';
  requires 'Dist::Zilla::Plugin::Git::Check';
  requires 'Dist::Zilla::Plugin::Git::GatherDir';
  requires 'Dist::Zilla::Plugin::Git::Push';
  requires 'Dist::Zilla::Plugin::Git::Tag';
  requires 'Dist::Zilla::Plugin::VersionFromModule';
  requires 'Carp::Always';
  requires 'Devel::Cover';
  requires 'Data::Printer';
  requires 'Carp::Always';
  requires 'Test::Pod';
  requires 'Devel::CoverReport';
};
on 'test' => sub {
  requires 'File::Slurper';
  requires 'YAML';
  requires 'Test::More';
  requires 'Test::Timer';
  requires 'Test::Exception';
  requires 'Test::Warnings';
  requires 'Class::Unload';
};
