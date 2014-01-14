package Math::Homogeneous;

use strict;
use warnings;
use base 'Exporter';
use Clone qw/ clone /;
use overload
    '<>' => \&get,
    fallback => 1;

our $VERSION = "0.01";

our @EXPORT = qw/ homogeneous /;
our @EXPORT_OK = qw/ homo /;

sub homogeneous {
  my $r = shift;
  my $array = ref $_[0] eq 'ARRAY' ? $_[0] : \@_;
  die if $r < 0;
  return [] if $r == 0;
  return [ map { [ $_ ] } @$array ] if $r == 1;
  my $homo = &homogeneous($r-1, $array);
  my $return = [];
  foreach my $h (@$homo) {
    for (@$array) {
      my $clone_h = clone $h;
      push @$clone_h, $_;
      push @$return, $clone_h;
    }
  }
  $return;
}

sub homo { &homogeneous(@_); }

sub new {
  my $class = shift;
  my $homo = homogeneous @_;
  my $iterator = {
    current  => 0,
    length   => scalar @$homo,
    iteratee => $homo,
  };
  bless($iterator, $class);
}

sub next {
  my $self = shift;
  return undef unless $self->has_next;
  $self->{iteratee}[$self->{current}++];
}

sub has_next {
  my $self = shift;
  $self->{current} < $self->{length};
}

sub get {
  my $self = shift;
  wantarray ? @{$self->{iteratee}} : $self->next;
}

1;
__END__

=encoding utf-8

=head1 NAME

Math::Homogeneous

=head1 SYNOPSIS
Function
    use Math::Homogeneous;

    my @n = qw/ a b c /;
    my $homogeneous = homogeneous(2, @n);

    for (@$h) {
      print join(',', @$_) . "\n";
    }

output:
    a,a
    a,b
    a,c
    b,a
    b,b
    b,c
    c,a
    c,b
    c,c

Iterator
    use Math::Homogeneous;

    my @n = qw/ a b c /;
    my $homo = Math::Homogeneous->new(2, @n);
    
    while (<$homo>) {
      print join(',', @$_) . "\n";
    }

output:
    a,a
    a,b
    a,c
    b,a
    b,b
    b,c
    c,a
    c,b
    c,c

=head1 DESCRIPTION

Perform homogeneous product.

=head1 LICENSE

Copyright (C) hoto.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

hoto E<lt>hoto17296@gmail.comE<gt>

=cut

