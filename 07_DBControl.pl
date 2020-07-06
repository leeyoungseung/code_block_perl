#!/usr/bin/perl

use strict;
use warnings;
use v5.10; # for say() function

use DBI;
say "Perl MySQL Connect Demo";
# MySQL database configuration
my $dsn = "DBI:mysql:perl_test";
my $username = "root";
my $password = '0000';

# connect to MySQL database
my %attr = ( PrintError=>0,  # turn off error reporting via warn()
            RaiseError=>1); # turn on error reporting via die()           

my $dbh = DBI->connect($dsn,$username,$password, \%attr);

say "Connected to the MySQL database.";

my $query = 'select * from member where num in (?,?,?,?)';

my $sth = $dbh -> prepare($query) or die "prepare failed : $dbh->errstr()";

$sth -> execute(1,2,3,6) or die "execute failed : $dbh->errstr()";

while(my @ary = $sth -> fetchrow()) {
  print "$ary[0],$ary[1],$ary[2],$ary[3],$ary[4]\n";
}

$sth -> finish();
$dbh -> disconnect();

exit 0;
