<?php
include 'connection.php';
include 'util.php';
if($_SERVER['REQUEST_METHOD']=='POST'){
$pass=$_POST['password'];
$email=$_POST['email'];
$fname=$_POST['fullname'];

$qcek="SELECT * FROM userLogin WHERE email='$email' ";
$rescek=$connect->query($qcek)->num_rows;
$qreg="INSERT INTO `userLogin` (`id`, `fullname`, `email`, `password`) 
        VALUES (NULL, '$fname', '$email',  SHA1('$pass'))";
$resreg=$connect->query($qreg);
    if($rescek>0){
    echo json_encode(createResponse(0,'email telah digunakan',""));
    }elseif($resreg){
    echo json_encode(createResponse(1,'register berhasil',""));
}else if(!$resreg){ 
    echo json_encode(createResponse(0,'register gagal dilakukan',""));
}
}
?>