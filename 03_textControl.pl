#!/usr/bin/perl
use strict; 
use warnings;
use Cwd;
use Config;

my @list = qw(david1 david2 david3 david4 david5 david6 david7);
###############################
###########   Main   ##########
###############################

my $oneStr = makeOneStrFromList(',' , @list);
print $oneStr . "\n";

my $seperator = ",";
my @resList1 = makeListFromStr($seperator,$oneStr);
print @resList1;
print "\n";

my $currentDir = getcwd;
my @resList2 = makeListFromStr('/',$currentDir);
print @resList2;
print "\n";

my $resStr = makePathTargetOS($Config{osname},@resList2);
print $resStr . "\n";
        

###############################
########### Function ##########
###############################
# Check OS Version and Change Dir Path suitable OS
sub makePathTargetOS {
    my ($osType,@targetList) = @_;
    print "makePathTargetOS\n";

    if ($osType eq ''| !@targetList){
        print "param is null \n";
        print "ostype : $osType\n";
        print "list elements \n";
        print @targetList;
        print "\n";
        return '';
    }

    my $resStr = '';
    if ($osType eq 'MSWin32' | $osType eq 'MSWin64') {
        $resStr = makeOneStrFromList('\\',@targetList); 
    } elsif ($osType eq 'linux') {
        $resStr = makeOneStrFromList('/',@targetList); 
    } else {
        $resStr = makeOneStrFromList('/',@targetList); 
    }

    return $resStr;
}

sub makeListFromStr {
    my ($seperator,$targetStr) = @_;
    print "makeListFromStr\n";
    
    if ($targetStr eq '') {
        print "targetStr is null\n";
        return "";
    }
    
    my @resultList = split(/$seperator/, $targetStr);
    return @resultList;    
}

sub makeOneStrFromList {
    my ($seperator,@targetList) = @_;
    print "makeOneStrFromList\n";
    
    if (!@targetList) {
        print "targetList is null\n";
        return "";
    }

    #my $resultStr = join ",", @targetList;
    my $resultStr = join $seperator, @targetList;
    return $resultStr;
}
