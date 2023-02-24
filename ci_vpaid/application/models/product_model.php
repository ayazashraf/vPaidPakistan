<?php
require_once('../ci_vpaid/includes/config.inc.php');
//require_once('../ci_vpaid/application/config.php');
class product_model extends CI_Model{
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

	function getProduct($place_id){	

		//$query = $this->db->query('SELECT product_id FROM `product_place` WHERE place_id ='.$place_id);
		$query = $this->db->query('SELECT * FROM `product` INNER JOIN product_place ON product.product_id=product_place.product_id AND product_place.place_id ='.$place_id);



		if ($query->num_rows() > 0) {
			$data = array();
		    foreach ($query->result() as $row) {
			   $data[] = $row;
		    }
			$array = array(
            "status" => "OK",
            "products" => $data
            );
			return $array;
		}
		else{
       	   $data[] = NULL;
		   $array = array(
           "status" => "NOT OK",
           "products" => $data
           );
			return $array;
       }   
	}
}
?>
