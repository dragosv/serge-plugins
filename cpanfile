requires 'perl' => '5.010001';
requires 'Serge';

on 'develop' => sub {
  requires 'Template';
  requires 'Dist::Zilla';
  requires 'Dist::Zilla::Plugin::Prereqs::FromCPANfile';
  requires 'Dist::Zilla::Plugin::VersionFromMainModule';
  requires 'Dist::Zilla::Plugin::UploadToCPAN';
  requires 'Dist::Zilla::Plugin::RunExtraTests';
  requires 'Dist::Zilla::Plugin::Test::Perl::Critic';
  requires 'Dist::Zilla::Plugin::Test::Perl::Critic::Freenode';
  requires 'Dist::Zilla::Plugin::Test::Compile';
  requires 'Dist::Zilla::Plugin::VersionFromModule';
  requires 'Dist::Zilla::Plugin::ConfirmRelease';
  requires 'Dist::Zilla::Plugin::TestRelease';
  requires 'Dist::Zilla::Plugin::UploadToCPAN';
  requires 'Dist::Zilla::Plugin::Test::Version';
  requires 'Dist::Zilla::Plugin::ReadmeAnyFromPod';
};
on 'test' => sub {
  requires 'Test::More';
  requires 'Test::Timer';
  requires 'Test::Exception';
  requires 'Test::Warnings';
  requires 'Class::Unload';
  requires 'Devel::Cover';
  requires 'Devel::Cover::Report::Codecov';
};
