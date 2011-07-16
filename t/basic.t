use strict;
use warnings;
use Test::More;

use File::Temp qw(tempdir);
use IO::File;
use Git::Wrapper;
use File::Spec;
use File::Path qw(mkpath);
use POSIX qw(strftime);
use Test::Deep;

my $dir = tempdir(CLEANUP => 1);

my $git = Git::Wrapper->new($dir);

$git->init;

mkpath(File::Spec->catfile($dir, 'foo'));

IO::File->new(">" . File::Spec->catfile($dir, qw(foo bar)))->print("hello\n");

is_deeply(
  [ $git->ls_files({ o => 1 }) ],
  [ 'foo/bar' ],
);

$git->add('.');
is_deeply(
  [ $git->ls_files ],
  [ 'foo/bar' ],
);

is( $git->status->is_dirty , 1 , 'repo is dirty' );

my $time = time;
$git->commit({ message => "FIRST\n\n\tBODY\n" });

is( $git->status->is_dirty , 0 , 'repo is clean' );

my @rev_list =
  $git->rev_list({ all => 1, pretty => 'oneline' });
is(@rev_list, 1);
like($rev_list[0], qr/^[a-f\d]{40} FIRST$/);

my @log = $git->log({ date => 'raw' });
is(@log, 1, 'one log entry');
my $log = $log[0];
is($log->id, (split /\s/, $rev_list[0])[0], 'id');
is($log->message, "FIRST\n\n\tBODY\n", "message");
my $log_date = $log->date;
$log_date =~ s/ [+-]\d+$//;
cmp_ok(( $log_date - $time ), '<=', 5, 'date');

SKIP: {
    # Test empty commit message
    IO::File->new(">" . File::Spec->catfile($dir, qw(second_commit)))->print("second_commit\n");
    $git->add('second_commit');
    eval {
      $git->commit({ message => "", 'allow-empty-message' => 1 });
    };

    if ( $@ ){
      skip substr($@,0,50), 1;
    }

    @log = $git->log();
    is(@log, 2, 'two log entries, one with empty commit message');
};


done_testing();
