<?php

//define("DB_HOST", "mysql.demo.foreigntree.com");
//define("DB_USER", "demoforeigntreec");
//define("DB_PASS", "ftsdemo");
//define("DB_NAME", "pocketglobe");
//define("BASE_URL", "http://demo.foreigntree.com/pocketglobe.net");
 
//define("DB_HOST", "localhost");
//define("DB_USER", "admin");
//define("DB_PASS", "admin");
//define("DB_NAME", "pocketglobe");
//define("BASE_URL", "http://localhost/PocketglobeDemo");
set_time_limit(120);
error_reporting(1);


define("DB_HOST", "localhost");
define("DB_USER", "root");
define("DB_PASS", "");
define("DB_NAME", "vpaid");
define("BASE_URL", "http://localhost/ci_vpaid/");


/* Facebook App Info */
define("FB_APP_ID", "630359626975342");
define("FB_APP_SECRET", "f4d6e476e82906cebb2798e9d2c1927b");
define("FB_APP_REDIRECT_URI", "http://184.173.19.10/");	// redirect user after login

/* Twitter App Info */
define("CONSUMER_KEY", "Nfhm2b7H8xlcrXA5ePvKDw");		
define("CONSUMER_SECRET", "MYzKya26SvCS3yedhIlMEYUW7IIarWFHsTqbd4ww");	//oAuth Nonce
define('OAUTH_CALLBACK', 'http://184.173.19.10/tw_login.php');
/*
session_start();
$session=session_id();
$time=time();
$time_check=$time-6; //SET TIME 10 Minute*/
$mysqli=new mysqli(DB_HOST,DB_USER,DB_PASS,DB_NAME);
/*
if(isset($_SESSION['user']))
{
$sql="SELECT * FROM users_online WHERE session_id='$session'";
$result=$mysqli->query($sql) or die($mysqli->error);

$count=$result->num_rows;
if($count=="0"){

$sql1="INSERT INTO  users_online(session_id,user_id,time)VALUES('$session','".$_SESSION['user']."','$time')";
$result1=$mysqli->query($sql1) or die($mysqli->error) ;
}

else {
$sql2="UPDATE users_online SET time='$time' , user_id='".$_SESSION['user']."' WHERE session_id = '$session'";
$result2=$mysqli->query($sql2) or die($mysqli->error) ;
}
}

$sql3="SELECT * FROM users_online";
$result3=$mysqli->query($sql3) or die($mysqli->error);
$count_user_online=$result3->num_rows;
//echo "User online : $count_user_online ";

// if over 10 minute, delete session 
$sql4="DELETE FROM users_online WHERE time<'$time_check' ";
$result4=$mysqli->query($sql4) or die($mysqli->error) ;*/
?>
