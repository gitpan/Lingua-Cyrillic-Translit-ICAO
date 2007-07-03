use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  'NAME'          => 'Lingua::Cyrillic::Translit::ICAO',
  'ABSTRACT'      => "Cyrillic characters transliteration into ICAO Doc 9303",
  'AUTHOR'        => 'Serguei Trouchelle <stro@railways.dp.ua>',
  'VERSION_FROM'  => 'ICAO.pm',
  'LICENSE'       => 'perl',
  'PREREQ_PM' => {
    'Text::Iconv' => 1.4,
  },

);
