#!/usr/bin/perl
use strict; 
use warnings;
use Cwd;
use File::Path;

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
print "\n";

### Update ####
my @appendData = (
    ['tiger16','tiger17','tiger18'],
    ['tiger19','tiger20','tiger21'],
    ['tiger22','tiger23','tiger24'],
);

appendCsvFile($testFile1, @appendData);

print readCsvFile($testFile1);
print "\n";


### Delete ####
#deleteDir($targetDir,0);

#deleteFile($testFile1);

deleteDir($targetDir,1);

exit 0;


###############################
########### Function ##########
###############################

# flg : 0 normal , flg : 1 force delete; if you allocate flg 1 you can delete not empty dir. 
sub deleteDir {
    my ($targetDir,$flg) = @_;
    print "deleteDir\n";

    if ($targetDir eq '') {
        print "param is null \n";
    }

    if ($flg eq '' || $flg eq 0) {
        rmdir ($targetDir) or die "failure to delete dir [$targetDir]\n";
    } else {
        # use File::Path:rmtree
        rmtree($targetDir) or die "fafilure to force delete dir [$targetDir]\n";
    }

    if (-e $targetDir){
        print "Directory '$targetDir' still exists\n";
        return 1;
    } else {
        print "Directory '$targetDir' deleted.\n";
        return 0;
    }
}

sub appendCsvFile {
    my ($fileName, @data) = @_;
    print "appendCsvFile\n";

    if ($fileName eq '' | !@data) {
        print "param is null filename [$fileName], data [@data]\n";
        return '';
    }

    # -e  File or directory exists
    if ( -e $fileName) {
        print "File is exist! [$fileName]\n";
    } else {
        print "File is not exist! [$fileName]\n";
    }

    # -r  File or directory is readable
    # -w  File or directory is writable
    if (! -r $fileName && ! -w $fileName) {
        print "This file can't read or write \n";
        return '';
    }

    open (PUT, ">>$fileName") or die "$!";

    foreach my $var (@data) {
        my @target = @$var;
        print PUT makeOneStrFromList(",",@target) . "\n";
    }
    
    close(PUT);
    return $fileName;
}


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
