# ABSTRACT: AppLanga (https://www.applanga.com/) synchronization plugin for Serge

package Serge::Sync::Plugin::TranslationService::applanga;
use parent Serge::Sync::Plugin::Base::TranslationService, Serge::Interface::SysCmdRunner;

use strict;

use Serge::Util qw(subst_macros);
use version;

our $VERSION = qv('0.900.1');

sub name {
    return 'AppLanga translation software (https://www.applanga.com/) synchronization plugin';
}

sub init {
    my $self = shift;

    $self->SUPER::init(@_);

    $self->{optimizations} = 1; # set to undef to disable optimizations

    $self->merge_schema({
        root_directory => 'STRING',
        draft => 'BOOLEAN'
    });
}

sub validate_data {
    my ($self) = @_;

    $self->SUPER::validate_data;

    $self->{data}->{root_directory} = subst_macros($self->{data}->{root_directory});
    $self->{data}->{draft} = subst_macros($self->{data}->{draft});

    die "'root_directory', which is set to '$self->{data}->{root_directory}', does not point to a valid folder." unless -d $self->{data}->{root_directory};

    $self->{data}->{draft} = 0 unless defined $self->{data}->{draft};
}

sub run_applanga_cli {
    my ($self, $action, $langs, $capture) = @_;

    my $command = $action;

    $command = 'applanga ' . $command;

    print "Running '$command'...\n";
    return $self->run_in($self->{data}->{root_directory}, $command, $capture);
}

sub pull_ts {
    my ($self, $langs) = @_;

    return $self->run_applanga_cli('pull', $langs);
}

sub push_ts {
    my ($self, $langs) = @_;

    my $action = 'push --force';

    if ($self->{data}->{draft}) {
        $action = $action.' --draft';
    }

    $self->run_applanga_cli($action, $langs);
}

1;