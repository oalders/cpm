package App::cpm::Worker::Resolver::Menlo;
use strict;
use warnings;
use utf8;

sub new {
    my ( $class, %option ) = @_;
    bless {%option}, $class;
}

sub work {
    my ( $self, $job ) = @_;

    my $search = $self->{menlo}->search_module( $job->{package} );

    return $search
        ? {
        ok       => 1,
        distfile => $search->{pathname},
        version  => $search->{version},
        provides => [
            { package => $search->{module}, version => $search->{version} }
        ],
        from => "menlo",
        }
        : { ok => 0 };
}

1;
