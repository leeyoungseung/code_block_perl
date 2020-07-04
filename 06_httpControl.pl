#!/usr/bin/perl
use strict; 
use warnings;
use LWP::UserAgent; # yum install perl perl-libwww-perl

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



###############################
########### Function ##########
###############################
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

