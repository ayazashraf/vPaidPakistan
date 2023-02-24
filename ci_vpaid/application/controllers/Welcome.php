<?php
require(APPPATH.'/libraries/REST_Controller.php');
// use namespace

defined('BASEPATH') OR exit('No direct script access allowed');
use ci_vpaid\Libraries\REST_Controller;

class Welcome extends REST_Controller {

	public function index_get()
	{
		//$this->load->libraries('../REST_Controller.php');
		$this->load->model('restaurant_model');
		$data[] = $this->restaurant_model->getRestaurant();
		//$data['status'] = "Ok";
		//$result = 
		if($data['places'] == NULL){
			$data['status'] = "Not Ok";
			echo json_encode($data);
		}
		else{
			echo json_encode($data);
			echo "No data";
		}
	}

	public function Restaurants_get(){
		echo "Test";
         //$data[] = $this->restaurant_model->getRestaurant();
         //$this->response($data,200);
     }
}
