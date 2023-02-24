<?php
require_once('../includes/config.inc.php');  
error_reporting(E_ALL);
	

	$query = "SELECT * FROM `business` WHERE is_active = '1' AND is_delete = '0'";
    $result = $mysqli->query($query) or die($mysqli->error);
    $data = array();
	if ($result->num_rows > 0) {
		
        //return $query->result();
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
           $data[] = $row;
           //$data['status'] = "OK";
          
        }
        $array = array(
        "status" => "OK",
        "places" => $data
         );
         echo json_encode( $array );
	       }
	else{
		//return NULL;
       $data[] = $result; 
       
       $array = array(
        "status" => "OK",
        "places" => $data
         );
         echo json_encode( $array );
         
	}
	
?>

