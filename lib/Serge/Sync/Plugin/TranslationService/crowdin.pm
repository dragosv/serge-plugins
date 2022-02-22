# ABSTRACT: Crowdin (https://crowdin.com) synchronization plugin for Serge

package Serge::Sync::Plugin::TranslationService::crowdin;
use parent Serge::Sync::Plugin::Base::TranslationService, Serge::Interface::SysCmdRunner;

use strict;

use Serge::Util qw(subst_macros);
use version;

our $VERSION = qv('0.903.3');

sub name {
    return 'Crowdin translation software (https://crowdin.com) synchronization plugin';
}

sub init {
    my $self = shift;

    $self->SUPER::init(@_);

    $self->{optimizations} = 1;

    $self->merge_schema({
        config_file => 'STRING',
        upload_translations => 'BOOLEAN',
        import_duplicates => 'BOOLEAN',
        import_eq_suggestions => 'BOOLEAN',
        auto_approve_imported => 'BOOLEAN',
        backoff_max_attempts => 'STRING',
        backoff_exp_base => 'STRING',
    });
}

sub validate_data {
    my ($self) = @_;

    $self->SUPER::validate_data;

    $self->{data}->{config_file} = subst_macros($self->{data}->{config_file});
    $self->{data}->{upload_translations} = subst_macros($self->{data}->{upload_translations});
    $self->{data}->{import_duplicates} = subst_macros($self->{data}->{import_duplicates});
    $self->{data}->{import_eq_suggestions} = subst_macros($self->{data}->{import_eq_suggestions});
    $self->{data}->{auto_approve_imported} = subst_macros($self->{data}->{auto_approve_imported});
    $self->{data}->{backoff_max_attempts} = subst_macros($self->{data}->{backoff_max_attempts});
    $self->{data}->{backoff_exp_base} = subst_macros($self->{data}->{backoff_exp_base});

    die "'config_file' not defined" unless defined $self->{data}->{config_file};
    die "'config_file', which is set to '$self->{data}->{config_file}', does not point to a valid file.\n" unless -f $self->{data}->{config_file};

    $self->{data}->{upload_translations} = 1 unless defined $self->{data}->{upload_translations};
    $self->{data}->{import_duplicates} = 0 unless defined $self->{data}->{import_duplicates};
    $self->{data}->{import_eq_suggestions} = 0 unless defined $self->{data}->{import_eq_suggestions};
    $self->{data}->{auto_approve_imported} = 0 unless defined $self->{data}->{auto_approve_imported};
    $self->{data}->{backoff_max_attempts} = 3 unless defined $self->{data}->{backoff_max_attempts};
    $self->{data}->{backoff_exp_base} = 8 unless defined $self->{data}->{backoff_exp_base};
}

sub run_crowdin_cli {
    my ($self, $action, $langs, $capture) = @_;

    my $command = $action;

    if ($langs) {
        foreach my $lang (sort @$langs) {
            $lang =~ s/-(\w+)$/'-'.uc($1)/e; # convert e.g. 'pt-br' to 'pt-BR'
            $command .= " -l=$lang";
        }
    }

    $command .= ' --config '.$self->{data}->{config_file};

    $command = 'crowdin '.$command;

    my $cli_return;
    for (
        my $attempt = 1;
        $attempt <= $self->{data}->{backoff_max_attempts} &&
            !eval {
                print "Running '$command'...\n";
                $cli_return = $self->run_cmd($command, $capture);
                return 1;
            };
        $attempt++
    ) {
        my $message = "Failed to call Crowdin CLI on attempt $attempt: $@\n";
        if ($attempt >= $self->{data}->{backoff_max_attempts}) {
            die $message;
        } else {
            print "Error. $message";
            my $sleep = $self->{data}->{backoff_exp_base} ** $attempt;
            print "Sleep for $sleep seconds\n";
            sleep $sleep;
        }
    }

    return $cli_return;
}

sub pull_ts {
    my ($self, $langs) = @_;

    return $self->run_crowdin_cli('download', $langs);
}

sub push_ts {
    my ($self, $langs) = @_;

    my $cli_return = $self->run_crowdin_cli('upload sources', ());

    if ($cli_return != 0) {
        return $cli_return;
    }

    if ($self->{data}->{upload_translations}) {
        my $action = 'upload translations';
        if ($self->{data}->{import_duplicates}) {
            $action .= ' --import-duplicates';
        }
        if ($self->{data}->{import_eq_suggestions}) {
            $action .= ' --import-eq-suggestions'
        }
        if ($self->{data}->{auto_approve_imported}) {
            $action .= ' --auto-approve-imported'
        }
        $cli_return = $self->run_crowdin_cli($action, $langs);
    }

    return $cli_return;
}

1;