use strict;
use warnings;
use Test::More;
use ABTest;

BEGIN{
    use_ok( 'Email::Valid' ) || print "Email::Valid not found\n";
    use_ok( 'Email::Address' ) || print "Email::Address not found \n";
    use_ok( 'ABTest' ) || print "ABTest not found \n";
    require_ok( 'Email::Valid' );
    require_ok( 'Email::Address' );
    require_ok( 'ABTest' );
};

subtest 'check test.txt file' => sub {
    my $file='test.txt';
    sub checkfile{
        if (-e $_[0]) { return 1;}
            else { return 0; }
    }
    ok(checkfile($file)==1,'File found');
};

subtest 'test email' => sub {
    my $test_email = 'username@domenname.com';
    my $el = length(Email::Valid->address($test_email));
    ok($el>0,'test address');
};

subtest 'test email domain path' => sub {
    my $test_email_d = 'username@domenname.com';
    my $el_d = Email::Address->parse($test_email_d);
    ok($el_d==1,'test email domian path');
};

done_testing();
