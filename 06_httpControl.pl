#!/usr/bin/perl
use strict; 
use warnings;
use LWP::UserAgent; # yum install perl perl-libwww-perl

################## XML Parsing ##########################
# It was so difficult to clear XML library's dependeny problem.
# So I'll retry when I finish all chapter of code_block project.  
#require './lib/XML-Parser-2.46/Parser.pm';
#require './lib/XML-Parser-2.46/Expat/Expat.pm';
#use lib './lib/XML';
#use lib './lib/XML/Expat';
#use lib './lib';
#use XML::Parser; # perl -MCPAN -e shell; install XML::Parser
################## XML Parsing ##########################

use JSON;
use Data::Dumper;

###############################
###########   Main   ##########
###############################
## GET Request
my $testGetUrl = "http://127.0.0.1/code_block_test/index.html";
requestGet($testGetUrl);

## Post Request With Form Data
my $testPostUrl = "http://127.0.0.1/code_block_test/postTest.php";
my %form;
$form{'id'} = "buildtiger";
$form{'nickname'} = "tiger11";

requestPost($testPostUrl, %form);


## Post Request With XML Data
my $testPostXmlUrl = "http://127.0.0.1/code_block_test/postTestXml.php";
my $testXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
  <RequestTest>
    <InfoHeader>
      <FunctionName>xml_test</FunctionName>
      <methodType>Post</methodType>
    </InfoHeader>
    <Contents>
      <Group>
         <GroupName>Build Team</GroupName>
         <GroupNumber>1</GroupNumber>
         <Data>
           <id>McCrane</id>
           <id>PowerJoe</id>
           <id>DumpSon</id>
           <id>DrillBoy</id>
         </Data>
      </Group>
      <Group>
         <GroupName>dragon</GroupName>
         <GroupNumber>2</GroupNumber>
         <Data>
           <id>Blue Eyes White Dragon</id>
           <id>Red Eyes Black Dragon</id>
         </Data>
      </Group> 
    </Contents>
  </RequestTest>
";

requestPostWithXML($testPostXmlUrl, $testXml);

## Post Request With Json Data
my $testPostJsonUrl = "http://127.0.0.1/code_block_test/postTestJson.php";
my $testJson ='[{
   "InfoHeader": {
      "FunctionName": "xml_test",
      "methodType": "Post"
   },
   "Contents": [
      {
         "GroupName": "Build Team",
         "GroupNumber": "1",
         "Data": [
            "McCrane",
            "PowerJoe",
            "DumpSon",
            "DrillBoy"
         ]
      },
      {
         "GroupName": "dragon",
         "GroupNumber": "2",
         "Data": [
            "Blue Eyes White Dragon",
            "Red Eyes Black Dragon"
         ]
      }
   ]
}]';

requestPostWithJSON($testPostJsonUrl, $testJson);


#my $data = parseJson($testJson);
my $data = decode_json($testJson);
print encode_json($data);
print "\n";
print "data : " . $data . "\n"; # Array
my @ary = $data;
print "ary[0] : " . $ary[0] . "\n";
print "ary[1] : " . $ary[1] . "\n";
print "\n";

foreach my $i (@$data) {
   print $i -> {Contents};
   print "\n";
   
}



#my %hash1 = %$data;
#print Dumper %hash1;
#print "\n";




###############################
########### Function ##########
###############################

sub parseJson {
    my ($json) = @_;
    print "parseJson\n";

    if ($json eq '') {
        print "data is null\n";
    }

    return decode_json($json);

}


sub requestPostWithJSON {
    my ($url, $json) = @_;
    print "requestPostWithJSON\n";

   if ($url eq '' || $url !~ /http[s]?/ ){
        print "param is null or fail matching pattern \n";
    }

    my $ua = LWP::UserAgent -> new;
    my $response = $ua -> post($url, Content_Type => 'application/json', Content => $json);

    if ($response -> is_success) {
        print $response -> decoded_content;
        print "success\n";
    } else {
        print $response -> status_line;
        print "failure\n";
    }
 

}

sub requestPostWithXML {
    my ($url, $xml) = @_;
    print "requestPostWithXML\n";

    if ($url eq '' || $url !~ /http[s]?/ ){
        print "param is null or fail matching pattern \n";
    }

    my $ua = LWP::UserAgent -> new;
    my $response = $ua -> post($url, Content_Type => 'text/xml', Content => $xml);

    if ($response -> is_success) {
        print $response -> decoded_content;
        print "success\n";
    } else {
        print $response -> status_line;
        print "failure\n";
    }
  
}



sub requestPost {
    my ($url,%form) = @_;
    print "requestPost\n";

    if ($url eq '' || $url !~ /http[s]?/ ){
        print "param is null or fail matching pattern \n";
    }

    my $ua = LWP::UserAgent -> new;
    my $response = $ua -> post($url, \%form);

    if ($response -> is_success) {
        print $response -> decoded_content;
        print "success\n";
    } else {
        print $response -> status_line;
        print "failure\n";
    }
  
}


sub requestGet {
    my ($url) = @_;
    print "requestGet\n";

    if ($url eq '' || $url !~ /http[s]?/ ){
        print "param is null or fail matching pattern \n";
    }

    my $ua = LWP::UserAgent -> new;
    my $response = $ua -> get($url);

    if ($response -> is_success) {
        print $response -> decoded_content;
        print "success\n";
    } else {
        print $response -> status_line;
        print "failure\n";
    }
}

