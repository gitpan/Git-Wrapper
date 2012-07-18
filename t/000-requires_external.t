#!perl

use Test::Most;
plan tests => 1;
bail_on_fail if 1;
use Env::Path 'PATH';

ok(scalar PATH->Whence($_), "$_ in PATH") for qw(git);

