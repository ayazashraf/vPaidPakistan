<?php

require(APPPATH.'/libraries/REST_Controller.php');
use ci_vpaid\Libraries\REST_Controller;


class ProductController extends REST_Controller {

   function __construct(){
      parent::__construct();
      $this->load->model('product_model');

      }

      public function Products_get(){
         
         $place_id = $this->get('place_id');
         //echo $merchant_id;

         $data = $this->product_model->getProduct($place_id);
         $this->response($data,200);

      }

}