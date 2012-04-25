
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Wrap git(7) command-line interface",
  "AUTHOR" => "Hans Dieter Pearcey <hdp\@cpan.org>, Chris Prather <chris\@prather.org>, John SJ Anderson <genehack\@genehack.org>",
  "BUILD_REQUIRES" => {
    "File::Path" => 0,
    "File::Spec" => 0,
    "IO::File" => 0,
    "POSIX" => 0,
    "Test::Deep" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Git-Wrapper",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Git::Wrapper",
  "PREREQ_PM" => {
    "File::Temp" => 0,
    "File::pushd" => 0,
    "IPC::Cmd" => 0,
    "IPC::Open3" => 0,
    "Sort::Versions" => 0,
    "Symbol" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.019",
  "test" => {
    "TESTS" => "t/*.t"
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



