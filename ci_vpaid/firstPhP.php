<!DOCTYPE html>

<?php
   /*if(!empty($_POST["myname"]) || !empty($_POST["email"])){
      $name = $_POST["myname"];
      $email = $_POST["email"];

      exit();
      }
      */
      /*$db_host = 'localhost';
      $db_user = 'root';
      $db_password = '';
      $db_name = 'ammartest';

      $con = mysqli_connect($db_host,$db_user,$db_password,$db_name);

      if(!empty($_POST['username']) || !empty($_POST['useremail']) || !empty($_POST['userage']) || !empty($_POST['userpassword'])){
         $user_name = $_POST['username'];
         $user_email = $_POST['useremail'];
         $user_pass = $_POST['userpassword'];
         $user_age = $_POST['userage'];

      if($con){
         $sql = "INSERT INTO `newtbluser`(`user_name`, `user_email`, `user_password`, `user_age`) VALUES ('$user_name','$user_email', '$user_pass', '$user_age')";
         $query = mysqli_query($con,$sql);
         if(!$query){
          echo "Query Failed".mysqli_error($con);
          exit();
         }
         else{
          header("Location:List.php");
         }
      }
      else{
         echo "Not Connected";
         exit();
      }

      }
   //echo "ABC";
   */
     /* $service_url = 'http://192.168.1.2/ci_vpaid/index.php/UserController/User';
$curl = curl_init($service_url);
$user_info = array(
        'firstname' => 'firstname',
        'lastname' => 'agent@example.com',
        'department' => 'departmentId001',
        'subject' => 'My first conversation',
        'recipient' => 'recipient@example.com',
        'apikey' => 'key001'
);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_POST, true);
curl_setopt($curl, CURLOPT_POSTFIELDS, $curl_post_data);
$curl_response = curl_exec($curl);
if ($curl_response === false) {
    $info = curl_getinfo($curl);
    curl_close($curl);
    die('error occured during curl exec. Additioanl info: ' . var_export($info));
}
curl_close($curl);
$decoded = json_decode($curl_response);
if (isset($decoded->response->status) && $decoded->response->status == 'ERROR') {
    die('error occured: ' . $decoded->response->errormessage);
}
echo 'response ok!';
var_export($decoded->response);*/
   ?>
<html>
   <body>
   
      <p>Please submit this form</p>
      
      <form action = "http://192.168.1.5/ci_vpaid_workingcopy/index.php/UserController/User" method = "POST" >
        <p><b>Name</b></p>
        <input type = "text" name= "user_firstname">
        <br/>
        <p><b>Email</b></p>
        <input type = "text" name="user_lastname">
        <br/>
        <p><b>Phone</b></p>
        <input type = "text" name="user_phone">
         <p><b>Token</b></p>
        <input type = "text" name="device_token">
        <br/>
         <p><b>OS</b></p>
        <input type = "text" name="os_id">
        <br/>
         <p><b>UDID</b></p>
        <input type = "text" name="device_udid">
        <br/>
        <p><b>user_lat</b></p>
        <input type = "text" name="user_lat">
        <br/>
        <p><b>user_lng</b></p>
        <input type = "text" name="user_lng">
        <br/>
        <p><b>Photo</b></p>
        <textarea name="user_photo"></textarea>
        <br/>
         <br/> <br/>
         <input type="submit"/> 
      </form>
   </body>
</html>