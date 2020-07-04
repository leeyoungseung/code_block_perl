<?php

//Make sure that this is a POST request.
if(strcasecmp($_SERVER['REQUEST_METHOD'], 'POST') != 0){
    //If it isn't, send back a 405 Method Not Allowed header.
    header($_SERVER["SERVER_PROTOCOL"]." 405 Method Not Allowed", true, 405);
   exit;
}

    $id = $_POST["id"];
    $nickname = $_POST["nickname"];

    $response = array();
    $response["success"] = true;
    $response["id"] = $id;
    $response["nickname"] = $nickname;

    echo json_encode($response);

?>
