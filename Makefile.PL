use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'AutoTwat',
    AUTHOR              => q{"Ryan Voots" <"simcop2387@simcop2387.info">},
    VERSION_FROM        => 'lib/AutoTwat.pm',
    ABSTRACT_FROM       => 'lib/AutoTwat.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'AutoTwat-*' },
);
