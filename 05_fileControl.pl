#!/usr/bin/perl
use strict; 
use warnings;
use Cwd;


###############################
###########   Main   ##########
############################### 
my @originData = (
    ['tiger1','tiger2','tiger3'],
    ['tiger4','tiger5','tiger6'],
    ['tiger7','tiger8','tiger9'],
    ['tiger10','tiger11','tiger12'],
    ['tiger13','tiger14','tiger15'],
);


### Create ####
my $currentDir = getcwd;
my $targetDir = "$currentDir/test_dir01";
my $testFile1 =  createCsvFile('testfile1.csv',$targetDir,@originData);
print $testFile1 ."\n";

###  Read  ####
print readCsvFile($testFile1);


### Update ####



### Delete ####


###############################
########### Function ##########
###############################

sub readCsvFile {
    my ($fileName) = @_;
    print "readCsvFile\n";

    open (IN, $fileName) or die "$!";
    my @resList = ();
    
    while(<IN>) {
        chomp ($_); # It removes characters at the end of strings corresponding($/). 

        my @data = split(/,/, $_); # make list seperated (,)

        print "------ read file result -------\n";
        print "$data[0],$data[1],$data[2]\n";
        push (@resList , @data); 
    }
   
    close(IN); 
    return @resList;
}

sub createCsvFile {
    my ($fileName,$targetDir,@data) = @_;
    print "createCsvFile\n";

    if ($fileName eq '' | $targetDir eq '' | !@data) {
        print "param is null filename [$fileName], targetDir [$targetDir], data [@data]\n";
        return '';
    }

    my $absolutePath = "$targetDir/$fileName";

    # -s File or directory exists and has nonzero size
    if ( -s $absolutePath) {
        print "File is already exist! [$absolutePath]\n";
        return $absolutePath;
    }
    
    # -e File or directory exists 
    if ( ! -e $targetDir ) {
        unless(mkdir($targetDir, 0755)) {
            die "Unable to create Dir [$targetDir]\n";
        }
        print "has been created Dir [$targetDir]";
    }
    
    # move to targetDir
    chdir($targetDir) or die "Unable to change dir [$targetDir]\n";

    # > it can Creates, Writes
    open(OUT , ">$fileName") or die "Can't make File [$fileName] Where [$targetDir] is.\n";

    foreach my $var (@data) {
        my @target = @$var;
        print OUT makeOneStrFromList(",",@target) . "\n";
    }

    close (OUT);

    # -z  File exists and has zero size (directories are never empty)
    if (-z $absolutePath) {
        if (deleteFile($absolutePath) == 0){
            print "file has been deleted because of it is empty [$absolutePath]!\n";
        } else {
            print "failure to delete file [$absolutePath] \n";
        }
        return '';
    }

    return $absolutePath;
}


sub deleteFile {
    my ($targetFile) = @_;
    print "deleteFile\n";

    if ($targetFile eq '') {
       print "param is null\n";
       return 1;
    }

    if (! -e $targetFile) {
       print "[$targetFile] is not exist.\n";
       return 1;
    }

    unlink($targetFile) or die "Can't delete $targetFile : $!\n";
    return 0;
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
