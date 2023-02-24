<!DOCTYPE html>

<?php
   
   ?>
<html>
   <body>
   
      <p>Please submit this form</p>
      
      <form action = "http://192.168.1.2/ci_vpaid_workingcopy/index.php/UserController/UserUpdate" method = "POST" >
        <p><b>user_id</b></p>
        <input type = "text" name= "user_id">
        <br/>
        <p><b>user_firstname</b></p>
        <input type = "text" name="user_firstname">
        <br/>
        <p><b>user_lastname</b></p>
        <input type = "text" name="user_lastname">
         <p><b>user_email</b></p>
        <input type = "text" name="user_email">
        <br/>
         <p><b>user_address</b></p>
        <input type = "text" name="user_address">
        <br/>
         <br/> <br/>
         <input type="submit"/> 
      </form>
   </body>
</html>