<?php 
include 'connection.php';
include 'util.php';
$var=$_SERVER['REQUEST_METHOD'];
if($var=='GET'){
    $res=Array();
    $res['movies']=Array();
        $q="SELECT * FROM `movie` ORDER BY year DESC";
        if($result=$connect->query($q)){
            $res['result']=1;
            
            while($data=$result->fetch_assoc()){
                $split=explode(',',$data['genres']);
                
                $data['genres']=$split;
                array_push($res['movies'],$data); 
            }
            echo json_encode($res);
        }else{
            $res['result']=0;
            echo json_encode($res);
        } 
}
?>