package Serge::Sync::Plugin::TranslationService::delta;
use parent Serge::Sync::Plugin::Base::TranslationService, Serge::Interface::SysCmdRunner;

use strict;

use Serge::Util qw(subst_macros);

sub name {
    return 'Delta (https://github.com/dragosv/delta) synchronization plugin';
}

sub init {
    my $self = shift;

    $self->SUPER::init(@_);

    $self->{optimizations} = 1; # set to undef to disable optimizations

    $self->merge_schema({
        config_file => 'STRING',
    });
}

sub validate_data {
    my ($self) = @_;

    $self->SUPER::validate_data;

    $self->{data}->{config_file} = subst_macros($self->{data}->{config_file});

    die "'config_file' not defined" unless defined $self->{data}->{config_file};
    die "'config_file', which is set to '$self->{data}->{config_file}', does not point to a valid file.\n" unless -f $self->{data}->{config_file};}

sub run_delta_cli {
    my ($self, $action, $langs, $capture) = @_;

    my $command = $action.' --config='.$self->{data}->{config_file};

    # if ($langs) {
    #     foreach my $lang (sort @$langs) {
    #         $lang =~ s/-(\w+)$/'_'.uc($1)/e; # convert e.g. 'pt-br' to 'pt_BR'
    #         $command .= " --language=$lang";
    #     }
    # }

    $command = 'delta '.$command;
    print "Running '$command'...\n";
    return $self->run_cmd($command, $capture);
}

sub pull_ts {
    my ($self, $langs) = @_;

    return $self->run_delta_cli('pull', $langs);
}

sub push_ts {
    my ($self, $langs) = @_;

    $self->run_delta_cli('push', $langs);
}

1;