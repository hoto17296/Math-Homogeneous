use strict;
use Test::More;
use Math::Homogeneous qw/ homo /;

use_ok $_ for qw/ Math::Homogeneous /;

subtest 'class method' => sub {
  my $got = homo(2, qw/ a b /);
  my $expect = [['a','a'],['a','b'],['b','a'],['b','b']];
  is_deeply $got, $expect, 'class method';
};

subtest 'iterator' => sub {
  my $iterator = Math::Homogeneous->new(2, qw/ a b /);

  my @got = <$iterator>;
  my $expect = [['a','a'],['a','b'],['b','a'],['b','b']];
  is_deeply \@got, $expect, 'array context';

  my $got = <$iterator>;
  $expect = ['a', 'a'];
  is_deeply $got, $expect, 'scalar context';
};

done_testing;
