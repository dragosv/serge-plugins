package Serge::Sync::Plugin::TranslationService::smartling;
use parent Serge::Sync::Plugin::Base::TranslationService, Serge::Interface::SysCmdRunner;

use strict;

use Serge::Util qw(subst_macros);

sub name {
    return 'Smartling (https://www.smartling.com) synchronization plugin';
}

sub init {
    my $self = shift;

    $self->SUPER::init(@_);

    $self->{optimizations} = 1; # set to undef to disable optimizations

    $self->merge_schema({
        config_file => 'STRING',
        directory => 'STRING',
        instrumented_lang => 'STRING',
        push_translations => 'BOOLEAN'
    });
}

sub validate_data {
    my ($self) = @_;

    $self->SUPER::validate_data;

    $self->{data}->{config_file} = subst_macros($self->{data}->{config_file});
    $self->{data}->{directory} = subst_macros($self->{data}->{directory});
    $self->{data}->{instrumented_lang} = subst_macros($self->{data}->{instrumented_lang});
    $self->{data}->{push_translations} = subst_macros($self->{data}->{push_translations});

    die "'config_file' not defined" unless defined $self->{data}->{config_file};
    die "'config_file', which is set to '$self->{data}->{config_file}', does not point to a valid file.\n" unless -f $self->{data}->{config_file};
    die "'directory' not defined" unless defined $self->{data}->{directory};
    die "'directory', which is set to '$self->{data}->{directory}', does not point to a valid directory.\n" unless -d $self->{data}->{directory};

    $self->{data}->{push_translations} = 1 unless defined $self->{data}->{push_translations};
}

sub run_smartling_cli {
    my ($self, $action, $langs, $capture) = @_;

    my $command = $action;

    if ($langs) {
        foreach my $lang (sort @$langs) {
            $lang =~ s/-(\w+)$/'-'.uc($1)/e; # convert e.g. 'pt-br' to 'pt-BR'
            $command .= " -l $lang";
        }
    }

    $command .= ' -c '.$self->{data}->{config_file}.' -d '.$self->{data}->{directory};

    $command = 'smartling-cli '.$command;

    if ($additional_args) {
        $command .= ' '.$additional_args;
    }

    print "Running '$command'...\n";
    return $self->run_cmd($command, $capture);
}

sub pull_ts {
    my ($self, $langs) = @_;

    my $cli_return = $self->run_smartling_cli('files pull --retrieve published', $langs);

    if ($cli_return != 0) {
        return $cli_return;
    }

    if ($self->{data}->{instrumented_lang} ne '') {
        my @instrumented_langs = ($self->{data}->{instrumented_lang});

        $cli_return = $self->run_smartling_cli('files pull --retrieve contextMatchingInstrumented', \@instrumented_langs, '');
    }

    return $cli_return
}

sub push_ts {
    my ($self, $langs) = @_;

    my $cli_return = $self->run_smartling_cli('files push', ());

    if ($cli_return != 0) {
        return $cli_return;
    }

    if ($self->{data}->{push_translations}) {
        $cli_return = $self->run_smartling_cli('files import', ());
    }

    return $cli_return;
}

1;