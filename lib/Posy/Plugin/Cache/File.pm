package Posy::Plugin::Cache::File;

#
# $Id: File.pm,v 1.2 2005/08/03 03:07:07 blair Exp $
#

use 5.008001;
use strict;
use warnings;
use Cache::File qw();

=head1 NAME 

Posy::Plugin::Cache::File - Filesystem-based cache for Posy plugins

=head1 VERSION

This document describes Posy::Plugin::Cache::File version B<0.1>.

=cut

our $VERSION = '0.1';

=head1 SYNOPSIS

This module is available for internal use by other Posy plugins.

  my $cache = Posy::Plugin::Cache::File->new(
    cache_root      => '/some/path',
    default_expires => '1w',
    lock_level      => Cache::File::LOCK_LOCAL 
  );
  $cache->put($key, $value);
  my $value = $cache->get($key);

=head1 DESCRIPTION

This module provides a filesytem-based cache (using L<Cache::File>)
that can be used internally by other L<Posy> plugins to cache data to
disk.

=head1 INTERFACE

=head2 new()

  my $cache = Posy::Plugin::Cache::File->new(
    cache_root      => '/some/path',
    default_expires => '1w',
    lock_level      => Cache::File::LOCK_LOCAL 
  );

Create a new filesystem-based with the specified arguments.

=cut
sub new {
  my ($class, @args) = @_;
  my $self = bless {}, ref($class) || $class;
  %$self = @args;
  # Provide some (marginally) sane default values
  $self->{cache_root}       ||= '/tmp/';
  $self->{default_expires}  ||= '1w';
  $self->{lock_level}       ||= Cache::File::LOCK_LOCAL;
  $self->{cache} = Cache::File->new(
    cache_root      => $self->{cache_root},
    default_expires => $self->{default_expires},
    lock_level      => $self->{lock_level}
  );
  return $self;
} # new()

=head2 get()
  
  my $value = $cache->get($key);

Retrieve a value from the cache.

=cut
sub get {
  my ($self, $key) = @_;
  return $self->{cache}->get($key); 
} # get()

=head2 set()

  $cache->set($key, $value);

Insert a value into the cache.

=cut
sub set {
  my ($self, $key, $value) = @_;
  $self->{cache}->set($key, $value);
} # set()

=head1 SEE ALSO

L<Perl>, L<Posy>, L<Cache::File>

=head1 TODO

=over 4

=item * Add L<Posy::Plugin::Log4perl> support

=item * Expose more L<Cache::File> capabilities

=back

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to
C<bug-Posy-Plugin-Cache-File@rt.cpan.org> or through the web interface at 
L<http://rt.cpan.org>.

=head1 AUTHOR

blair christensen., E<lt>blair@devclue.comE<gt>

<http://devclue.com/blog/code/posy/Posy::Plugin::Cache::File/>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by blair christensen.
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO
WARRANTY FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE
LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS
AND/OR OTHER PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE
OF THE SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE,
YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.


IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA
BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES
OR A FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY
OF SUCH DAMAGES.

=cut

1;

