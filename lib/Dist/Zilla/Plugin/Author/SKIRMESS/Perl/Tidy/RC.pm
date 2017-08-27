package Dist::Zilla::Plugin::Author::SKIRMESS::Perl::Tidy::RC;

use 5.006;
use strict;
use warnings;

our $VERSION = '0.005';

use Moose;

with qw(
  Dist::Zilla::Role::BeforeBuild
);

use Path::Tiny;

use namespace::autoclean;

sub before_build {
    my ($self) = @_;

    my $perltidyrc = <<'PERL_TIDY_RC';
--maximum-line-length=0
--break-at-old-comma-breakpoints
--backup-and-modify-in-place
--output-line-ending=unix
PERL_TIDY_RC

    path('.perltidyrc')->spew($perltidyrc);

    return;
}

1;

# vim: ts=4 sts=4 sw=4 et: syntax=perl
