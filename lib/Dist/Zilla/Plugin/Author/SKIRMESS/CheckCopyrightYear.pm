package Dist::Zilla::Plugin::Author::SKIRMESS::CheckCopyrightYear;

use 5.006;
use strict;
use warnings;

use Moose;

with qw(Dist::Zilla::Role::BeforeBuild);

has whitelisted_licenses => (
    is      => 'ro',
    isa     => 'ArrayRef[Str]',
    default => sub { [qw(Software::License::FreeBSD)] },
);

use namespace::autoclean;

sub before_build {
    my ($self) = @_;

    my $zilla   = $self->zilla;
    my $license = $zilla->license;

    my %whitelisted_license = map { $_ => 1 } @{ $self->whitelisted_licenses };

    my $license_package = ref $license;
    $self->log_fatal("License '$license_package' is not whitelisted") if !exists $whitelisted_license{$license_package};

    my $this_year = (localtime)[5] + 1900;
    my $year      = $license->year;
    if ( $year =~ m{ ^ [0-9]{4} $ }xsm ) {
        $self->log_fatal("Copyright year is '$year' but this year is '$this_year'. The correct copyright year is '$year-$this_year'") if $year ne $this_year;
        return;
    }

    $self->log_fatal("Copyright year must either be '$this_year' or 'yyyy-$this_year' but is '$year'") if $year !~ m{ ^ ( [0-9]{4} ) - ( [0-9]{4} ) $ }xsm;
    my $first_year = $1;
    my $last_year  = $2;

    $self->log_fatal("First year in copyright year must be a smaller number then second but is '$year'") if $first_year >= $last_year;

    $self->log_fatal("Copyright year is '$year' but this year is '$this_year'. The correct copyright year is '$first_year-$this_year'") if $last_year ne $this_year;

    return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::Author::SKIRMESS::CheckCopyrightYear - check that the copyright year is correct

=head1 VERSION

Version 0

=head1 SYNOPSIS

In your F<dist.ini>:

[Author::SKIRMESS::CheckCopyrightYear]

=head1 DESCRIPTION

This plugin runs before the build and checks that the license is one of our whitelisted licenses and that the copyright year makes sense.

=head2 required_file

Specifies a file that must be included in the distribution. The file must be specified as full path without the C<dist_basename>.

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/skirmess/dzil-inc/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/skirmess/dzil-inc>

  git clone https://github.com/skirmess/dzil-inc.git

=head1 AUTHOR

Sven Kirmess <sven.kirmess@kzone.ch>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017-2018 by Sven Kirmess.

This is free software, licensed under:

  The (two-clause) FreeBSD License

=cut

# vim: ts=4 sts=4 sw=4 et: syntax=perl
