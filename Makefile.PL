
use strict;
use warnings;

BEGIN { require 5.006; }

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'wrap git(7) command-line interface',
  'AUTHOR' => 'Hans Dieter Pearcey <hdp@cpan.org>, Chris Prather <chris@prather.org>',
  'BUILD_REQUIRES' => {
    'File::Path' => '0',
    'File::Spec' => '0',
    'File::Temp' => '0',
    'IO::File' => '0',
    'POSIX' => '0',
    'Test::Deep' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Git-Wrapper',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Git::Wrapper',
  'PREREQ_PM' => {
    'File::pushd' => '0',
    'IPC::Open3' => '0',
    'Symbol' => '0',
    'overload' => '0'
  },
  'VERSION' => '0.014',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



