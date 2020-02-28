# ABSTRACT: Localize (https://localizejs.com/) synchronization plugin for Serge

package Serge::Sync::Plugin::TranslationService::localize;
use parent Serge::Sync::Plugin::Base::TranslationService, Serge::Interface::SysCmdRunner;

use strict;

use File::chdir;
use File::Find qw(find);
use File::Spec::Functions qw(catfile abs2rel);
use JSON -support_by_pp; # -support_by_pp is used to make Perl on Mac happy
use Serge::Util qw(subst_macros);
use version;

our $VERSION = qv('0.900.0');

sub name {
    return 'Localize translation software (https://localizejs.com/) synchronization plugin';
}

sub init {
    my $self = shift;

    $self->SUPER::init(@_);

    $self->{optimizations} = 1; # set to undef to disable optimizations

    $self->merge_schema({
        root_directory => 'STRING',
        format => 'STRING',
        source_language        => 'STRING',
        target_languages    => 'ARRAY',
        project_key => 'STRING',
        private_api_key => 'STRING'
    });
}

sub validate_data {
    my ($self) = @_;

    $self->SUPER::validate_data;

    $self->{data}->{root_directory} = subst_macros($self->{data}->{root_directory});
    $self->{data}->{push_translations} = subst_macros($self->{data}->{push_translations});
    $self->{data}->{source_language} = subst_macros($self->{data}->{source_language});
    $self->{data}->{target_languages} = subst_macros($self->{data}->{target_languages});
    $self->{data}->{format} = subst_macros($self->{data}->{format});
    $self->{data}->{project_key} = subst_macros($self->{data}->{project_key});
    $self->{data}->{private_api_key} = subst_macros($self->{data}->{private_api_key});

    die "'root_directory' not defined" unless defined $self->{data}->{root_directory};
    die "'root_directory', which is set to '$self->{data}->{root_directory}', does not point to a valid file.\n" unless -d $self->{data}->{root_directory};
    die "'format' not defined" unless defined $self->{data}->{format};
    die "'project_key' not defined" unless defined $self->{data}->{project_key};
    die "'private_api_key' not defined" unless defined $self->{data}->{private_api_key};

    if (!exists $self->{data}->{target_languages} or scalar(@{$self->{data}->{target_languages}}) == 0) {
        die "the list of destination target_languages is empty";
    }

    $self->{data}->{source_language} = 'en' unless defined $self->{data}->{source_language};
}

sub pull_ts {
    my ($self, $langs) = @_;

    my $langs_to_push = $self->get_all_langs($langs);

    foreach my $lang (@$langs_to_push) {
        my $directory = catfile($self->{data}->{resource_directory}, $lang);

        my $lang_files_path = catfile($self->{data}->{root_directory}, $directory);
        my @files = $self->find_lang_files($lang_files_path);

        foreach my $file (@files) {
            my $full_path = catfile($directory, $file);
            my $cli_return = $self->run_localize_pull($lang, $full_path, $self->{data}->{format});

            if ($cli_return != 0) {
                return $cli_return;
            }
        }
    }

    return 0;
}

sub push_ts {
    my ($self, $langs) = @_;

    my $langs_to_push = $self->get_all_langs($langs);

    foreach my $lang (@$langs_to_push) {
        my $directory = catfile($self->{data}->{resource_directory}, $lang);

        my $lang_files_path = catfile($self->{data}->{root_directory}, $directory);
        my @files = $self->find_lang_files($lang_files_path);

        foreach my $file (@files) {
            my $full_path = catfile($directory, $file);
            my $cli_return = $self->run_localize_push($lang, $full_path, $self->{data}->{format});

            if ($cli_return != 0) {
                return $cli_return;
            }
        }
    }

    return 0;
}

sub get_all_langs {
    my ($self, $langs) = @_;

    if (!$langs) {
        $langs = $self->{data}->{target_target_languages};
    }

    my @all_langs = ($self->{data}->{source_language});

    push @all_langs, @$langs;

    return \@all_langs;
}

sub run_localize_pull {
    my ($self, $language, $file, $format) = @_;

    my $cli_return = 0;

    my $command = $action;

    $command = 'curl --request GET ';
    print "Running pull for $language ...\n";

    $command .= " --url 'https://api.localizejs.com/v2.0/projects/".$self->{data}->{project_key}."/resources?' ";
    $command .= "language=".$language."&type=phrase&format=".$format;
    $command .= " --header 'Authorization: Bearer ".$self->{data}->{private_api_key}."' ";

    my $curl_return = $self->run_in($self->{data}->{root_directory}, $command, 1);

    my $status = $self->json_status($curl_return);

    if ($status == '200') {
        return 0;
    }

    return 1;
}

sub run_localize_push {
    my ($self, $language, $file, $format) = @_;

    my $cli_return = 0;

    my $command = $action;

    $command = 'curl ';
    print "Running push for $language and $file ...\n";

    $command .= " -XPOST 'https://api.localizejs.com/v2.0/projects/".$self->{data}->{project_key}."/resources' ";
    $command .= " -H 'Authorization: Bearer ".$self->{data}->{private_api_key}."' ";
    $command .= " -F 'language='".$language."' ";
    $command .= " -F 'format='".$format."' ";
    $command .= " -F 'type='phrase' ";
    $command .= " -F 'content=@".$file."' ";
    $command .= " -H 'Content-Type: multipart/form-data'";

    my $curl_return = $self->run_in($self->{data}->{root_directory}, $command, 1);

    my $status = $self->json_status($curl_return);

    if ($status == '201') {
        return 0;
    }

    return 1;
}

sub json_status {
    my ($self, $json_response) = @_;

    my $json_tree = $self->parse_json($json_response);

    my @response = map { $_->{meta} } @$json_tree;

    my $response_length = scalar @response;

    if ($response_length == 1) {
        my $status = @response[0]->{status};

        return $status;
    }

    return '900';
}

sub find_lang_files {
    my ($self, $directory) = @_;

    my @files = ();

    find(sub {
        push @files, abs2rel($File::Find::name, $directory) if(-f $_);
    }, $directory);

    return @files;
}

sub parse_json {
    my ($self, $json) = @_;

    my $tree;
    eval {
        ($tree) = from_json($json, {relaxed => 1});
    };
    if ($@ || !$tree) {
        my $error_text = $@;
        if ($error_text) {
            $error_text =~ s/\t/ /g;
            $error_text =~ s/^\s+//s;
        } else {
            $error_text = "from_json() returned empty data structure";
        }

        die $error_text;
    }

    return $tree;
}

sub get_langs {
    my ($self, $langs) = @_;

    if (!$langs) {
        $langs = $self->{data}->{target_languages};
    }

    return $langs;
}

1;