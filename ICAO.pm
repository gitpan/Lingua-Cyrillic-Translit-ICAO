# Lingua/Cyrillic/Translit/ICAO.pm
#
# Copyright (c) 2007 Serguei Trouchelle. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

# History:
#  1.02  2007/07/04 POD fixes
#  1.01  2007/07/02 Initial revision

=head1 NAME

Lingua::Cyrillic::Translit::ICAO -- Cyrillic characters transliteration into ICAO Doc 9303

=head1 SYNOPSIS

 use Lingua::Cyrillic::Translit::ICAO qw/ cyr2icao /;

 print cyr2icao('ukrainian', 'koi8-r'); 

=head1 DESCRIPTION

Lingua::Cyrillic::Translit::ICAO can be used for transliteration of Cyrillic
characters in conformance with ICAO Doc 9303 Recommendations.

=head1 METHODS

=cut

package Lingua::Cyrillic::Translit::ICAO;

require Exporter;
use Config;

use strict;
use warnings;
use utf8;

use Text::Iconv;

our @EXPORT      = qw/ /;
our @EXPORT_OK   = qw/ cyr2icao /;
our %EXPORT_TAGS = qw / /;
our @ISA = qw/Exporter/;

our $VERSION = "1.02";

my $table = q!1 1
А A
Б B
В V
Г G
Д D
Е E
Ё E
Ж ZH
З Z
И I
І I
Й I
К K
Л L
М M
Н N
О O
П P
Р R
С S
Т T
У U
Ф F
Х KH
Ц TS
Ч CH
Ш SH
Щ SHCH
Ы Y
Ѣ IE
Э E
Ю IU
Я IA
Ѵ Y
Ґ G
Ў U
Ѫ U
Ѓ G
Ђ D
Ѕ DZ
Ј J
Ќ K
Љ LJ
Њ NJ
Һ C
Џ DZ
Є IE
Ї I
а a
б b
в v
г g
д d
е e
ё e
ж zh
з z
и i
і i
й i
к k
л l
м m
н n
о o
п p
р r
с s
т t
у u
ф f
х kh
ц ts
ч ch
ш sh
щ shch
ы y
ѣ ie
э e
ю iu
я ia
ѵ y
ґ g
ў u
ѫ u
ѓ g
ђ d
ѕ dz
ј j
ќ k
љ lj
њ nj
һ c
џ dz
є ie
ї i
2 2!;

our %cyr2icao = split /\s+/, $table;

# skip hard and soft signs
$cyr2icao{'Ъ'} = '';
$cyr2icao{'ъ'} = '';
$cyr2icao{'Ь'} = '';
$cyr2icao{'ь'} = '';

=head2 cyr2icao ( $string, [$language], [ $encoding ])

This method converts $string from Cyrillic character set to ICAO transliteration.

Optional $language parameter allow to specify $string's language. Valid values are:

=over 1

=item 'by' - Belorussian

=item 'bu' - Bulgarian

=item 'mk' - Macedonian

=item 'uk' - Ukrainian

=back

Other values are accepted but do not affect anything.

Optional $encoding parameter allows to specify $string's encoding (default is 'utf-8')

=cut

sub cyr2icao {
  my $val = shift;
  my $lang = shift;
  my $enc = shift;
  if ($enc) {
    my $converter = Text::Iconv->new($enc, "utf-8");
    $val = $converter->convert($val);
  } # else think of utf-8
  my $res = '';
  utf8::decode($val);
#  foreach (split //, $val) {  -- benchmarks say it's slower...
  foreach (0 .. length $val) {
    $_ = substr($val, $_, 1);
    $_ = 'H' if $_ eq 'Г' and ($lang eq 'by' or $lang eq 'mk');
    $_ = 'h' if $_ eq 'г' and ($lang eq 'by' or $lang eq 'mk');
    $_ = 'IO' if $_ eq 'Ё' and $lang eq 'by';
    $_ = 'io' if $_ eq 'ё' and $lang eq 'by';
    $_ = 'Z' if $_ eq 'Ж' and $lang eq 'mk';
    $_ = 'z' if $_ eq 'ж' and $lang eq 'mk';
    $_ = 'Y' if $_ eq 'И' and $lang eq 'uk';
    $_ = 'y' if $_ eq 'и' and $lang eq 'uk';
    $_ = 'H' if $_ eq 'Х' and $lang eq 'mk';
    $_ = 'h' if $_ eq 'х' and $lang eq 'mk';
    $_ = 'C' if $_ eq 'Ц' and $lang eq 'mk';
    $_ = 'c' if $_ eq 'ц' and $lang eq 'mk';
    $_ = 'C' if $_ eq 'Ч' and $lang eq 'mk';
    $_ = 'c' if $_ eq 'ч' and $lang eq 'mk';
    $_ = 'S' if $_ eq 'Ш' and $lang eq 'mk';
    $_ = 's' if $_ eq 'ш' and $lang eq 'mk';
    $_ = 'SHT' if $_ eq 'Щ' and $lang eq 'bg';
    $_ = 'sht' if $_ eq 'щ' and $lang eq 'bg';

    $_ = $cyr2icao{$_} if defined $cyr2icao{$_};
    $res .= $_;
  }
  return $res;
}

1;

=head1 AUTHORS

Serguei Trouchelle E<lt>F<stro@railways.dp.ua>E<gt>

=head1 COPYRIGHT

Copyright (c) 2007 Serguei Trouchelle. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

Lingua::RU::Translit - Transliteration of Russian text to Latin symbols.

Lingua::UK::Translit - Transliteration of Ukrainian text to Latin symbols.

=cut
