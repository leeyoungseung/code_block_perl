#!/usr/bin/perl
use strict; 
use warnings;

my $startCount = 2;
my $endCount = 100;

my @list = ("tiger1","tiger2","tiger3","tiger4","tiger5");

###############################
###########   Main   ##########
############################### 

print sumCount($startCount,$endCount) . "\n";

readListForeach(@list);

my %map = makeHashMap(@list);

readHashWhile(%map); 


###############################
########### Function ##########
###############################
sub readHashWhile{
    my %targetHash = @_;
    
    print "readHashWhile \n";

    my $su = 0;
    while ($su < 3) {
        $su++;
        print $targetHash{$su} . "\n";
    }
    
   
}

sub makeHashMap{
    my @targetList = @_;
    
    print "makeHashMap\n";
    my $end = $#targetList;
    
    my %resultHash;
    for (my $i = 0; $i < $end; $i++ ){
        $resultHash{$i} = "super build " . $targetList[$i];
        print "$resultHash{$i} \n";
    }
    
    return %resultHash;
}



sub readListForeach {
   my @outputList = @_;

   print "readList\n";

   ### default param ###
   print "default param\n";
   foreach (@outputList) {
       print "$_\n";
   }
   ### param setting ###
   print "param setting \n";
   foreach my $param (@outputList) {
       print "$param\n";
   }
}


sub sumCount{
    my ($start,$end) = @_;

    print "sumCount\n";
    if ($start eq '' | $start eq 0 | $end eq '' | $end eq 0) {
        print "Param is null First [$start], Second [$end]\n";
        return 1;
    }

    my $i = 0;
    my $resultSum = 0;

    ### Defualt ###
    for ($i = $start; $i <= $end; $i++) {
        $resultSum += $i;
    }

    ### using loop operator ###
    for ($start..$end, "david1","david2","david3"){
        if ($_ % 3 == 0) {
           print "skip end move to next\n";
           next; # like continue in Java
        }
        print $_ . "\n";
        
        if ($_ eq ($end - 30)) {
            print "Has been broken [$_] \n";
            last; # like break in Java
        }
    }

    return $resultSum;
}
