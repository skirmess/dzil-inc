#!perl

use 5.006;
use strict;
use warnings;

# this test was generated with
# Dist::Zilla::Plugin::Author::SKIRMESS::Test::XT::Test::Spelling 0.005

use Test::Spelling 0.12;
use Pod::Wordlist;

add_stopwords(<DATA>);

all_pod_files_spelling_ok(qw( bin lib ));
__DATA__
<sven.kirmess@kzone.ch>
Kirmess
SKIRMESS
Sven
dist
