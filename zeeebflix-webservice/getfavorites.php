<?php 
include 'connection.php';
include 'util.php';
$var=$_SERVER['REQUEST_METHOD'];
if($var=='GET'){
    if(isset($_GET['email'])){
        $res=Array();
        $email=$_GET['email'];
    $res['movies']=Array();
        $q="SELECT id FROM `favorite` WHERE email='$email'";
        if($result=$connect->query($q)){
            $res['result']=1;
            while($data=$result->fetch_assoc()){

                array_push($res['movies'],$data);
               
                
            }
            echo json_encode($res);
        }else{
            $res['result']=0;
            echo json_encode($res);;
        }
    }
}
?>