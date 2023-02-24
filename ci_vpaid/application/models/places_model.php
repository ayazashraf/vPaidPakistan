<?php
require_once('../ci_vpaid/includes/config.inc.php');
//require_once('../ci_vpaid/application/config.php');
class places_model extends CI_Model{
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	function getPlaces(){	
		$query = $this->db->query('SELECT * FROM `places` WHERE is_active = 1 AND is_delete = 0');
		
		if ($query->num_rows() > 0) {
			$data = array();
		    foreach ($query->result() as $row) {
			   $data[] = $row;
		    }
			$array = array(
            "status" => "OK",
            "places" => $data
            );
			return $array;
		}
		else{
       	   $data[] = NULL;
		   $array = array(
           "status" => "NOT OK",
           "places" => $data
           );
			return $array;
       }   
	}
}
?>
