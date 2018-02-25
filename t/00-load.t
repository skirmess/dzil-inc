#!perl

use 5.006;
use strict;
use warnings;

# generated by Dist::Zilla::Plugin::Author::SKIRMESS::RepositoryBase 0.033

use Test::More;

use lib qw(lib);

my @modules = qw(
  Dist::Zilla::Plugin::Author::SKIRMESS::CPANFile
  Dist::Zilla::Plugin::Author::SKIRMESS::InsertVersion
  Dist::Zilla::Plugin::Author::SKIRMESS::RemoveDevelopPrereqs
  Dist::Zilla::Plugin::Author::SKIRMESS::RepositoryBase
  Dist::Zilla::Plugin::Author::SKIRMESS::RunExtraTests::FromRepository
  Dist::Zilla::PluginBundle::Author::SKIRMESS
);

plan tests => scalar @modules;

for my $module (@modules) {
    require_ok($module) || BAIL_OUT();
}
