#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'AutoTwat' ) || print "Bail out!
";
}

diag( "Testing AutoTwat $AutoTwat::VERSION, Perl $], $^X" );
