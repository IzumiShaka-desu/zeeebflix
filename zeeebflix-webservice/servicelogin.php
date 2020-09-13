<?php 
include 'connection.php';
include 'util.php';
if($_SERVER['REQUEST_METHOD']=='POST'){
    
    $email=$_POST['email'];
    $pass=$_POST['password'];
    $query = "SELECT * FROM userLogin WHERE email='$email' and
password=SHA1('$pass')";
    $result=$connect->query($query)->num_rows;
    if($result>0){
        $data=$connect->query($query)->fetch_assoc();
    echo(json_encode(createResponse(1,"login berhasil",$data['fullname'])));
    }else{
        
        echo(json_encode(createResponse(0,"login gagal","")));
    }
}
?>