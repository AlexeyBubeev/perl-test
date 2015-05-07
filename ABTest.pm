#!/usr/bin/env perl
=pod
Имена доменов и количество адресов в каждом домене. Сортировка по количеству адресов в домене, по убыванию. Отдельной строкой — количество не валидных адресов. Пример:
     mail.ru     2
     vk.com      1
     rambler.ru  1
     INVALID     1
=cut

package ABTest;

#use strict;
#use warnings;
use Email::Valid; # все стандарты email адресов
use Email::Address; # корректная работа с адресами
use 5.18.2;


open FILE, "test.txt" or die $!;
my (%emails,$bad_count);

$bad_count = 0;

while (my $line = <FILE>) {
    chomp($line); # отсекаем символ \n
    if (Email::Valid->address($line)){
        my ($addr) = Email::Address->parse($line);
        $emails{$addr->host}++;
    } else {
        $bad_count++;
    }
}
close FILE;

foreach my $str (sort keys %emails) {
    printf "%-31s %s\n", $str, $emails{$str};
}

print "INVALID:".$bad_count;

1;