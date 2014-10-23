#!/usr/bin/env perl -w

use strict;

use Test;

BEGIN { plan tests => 2 }

use Lingua::Cyrillic::Translit::ICAO;

ok(Lingua::Cyrillic::Translit::ICAO::cyr2icao('����', 'uk', 'cp866'), 'pyvo');
ok(Lingua::Cyrillic::Translit::ICAO::cyr2icao('���襫�', 'uk', 'cp866'), 'Trushel');

exit;
