<?php
        function createResponse($result,$message,$fnameData){
            $response=array();
            $response['message']=$message;
            $response['result']=$result;
            $response['fnameData']=$fnameData;
            return $response;
        }
  
?>