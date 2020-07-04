<?php
//Make sure that this is a POST request.
if(strcasecmp($_SERVER['REQUEST_METHOD'], 'POST') != 0){
    //If it isn't, send back a 405 Method Not Allowed header.
    header($_SERVER["SERVER_PROTOCOL"]." 405 Method Not Allowed", true, 405);
   exit;
}

//Get the raw POST data from PHP's input stream.
//This raw data should contain XML.
$postData = trim(file_get_contents('php://input'));
 
 
//Use internal errors for better error handling.
libxml_use_internal_errors(true);
 
 
//Parse the POST data as XML.
$xml = simplexml_load_string($postData);



header("Content-type: text/xml; charset=utf-8");
echo print_r($xml);

?>
