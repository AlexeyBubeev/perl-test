#!/usr/bin/env perl
=pod
Имена доменов и количество адресов в каждом домене. Сортировка по количеству адресов в домене, по убыванию. Отдельной строкой — количество не валидных адресов. Пример:
     mail.ru     2
     vk.com      1
     rambler.ru  1
     INVALID     1
=cut

package ABTest;

use strict;
use warnings;
#use diagnostics;

use Email::Valid; # все стандарты email адресов
use Email::Address; # корректная работа с email
use 5.18.2;

open FILE, "../test.txt" or open FILE, "test.txt" or die "Can't open file test.txt";
my (%emails,$bad_count,$adr_length,$max_length);

$bad_count = 0;
$max_length = 0;

while (<FILE>) {
    chomp; # отсекаем символ \n
    if (Email::Valid->address($_)){
        my ($addr) = Email::Address->parse($_);
        $emails{$addr->host}++;
        my $adr_length = length($addr->host);
        if($max_length < $adr_length){
            $max_length = $adr_length;
        }
    } else {
        $bad_count++;
    }
}
close FILE;

$max_length = ($max_length)*-1;

foreach my $str (sort keys %emails) {
    printf "%${max_length}s %s\n", $str, $emails{$str};
}

print "INVALID:".$bad_count;



1;