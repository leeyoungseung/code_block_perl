<?php
if(strcasecmp($_SERVER['REQUEST_METHOD'], 'POST') != 0){
    //If it isn't, send back a 405 Method Not Allowed header.
    header($_SERVER["SERVER_PROTOCOL"]." 405 Method Not Allowed", true, 405);
   exit;
}

//Get the raw POST data from PHP's input stream.
//This raw data should contain XML.
$json = json_decode(file_get_contents('php://input'), true);


echo print_r($json); 

?>
