<?php

require(APPPATH.'/libraries/REST_Controller.php');
use ci_vpaid\Libraries\REST_Controller;


class PlacesController extends REST_Controller {

   function __construct(){
      parent::__construct();
      $this->load->model('places_model');

      }

      public function Places_get(){
         // $this->load->libraries('../REST_Controller.php');
         $data = $this->places_model->getPlaces();
         $this->response($data,200);

      }

}