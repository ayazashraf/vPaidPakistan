<?php

require(APPPATH.'/libraries/REST_Controller.php');
use ci_vpaid\Libraries\REST_Controller;


class UserController extends REST_Controller {

   function __construct(){
      parent::__construct();
     

      }

      public function User_post(){  //This controller method is registering user
        
      	 $this->load->model('user_model');

         $params_firstName = $this->post('user_firstname');  // firstname = user_firstname
         $params_lastName = $this->post('user_lastname'); // lastname = user_lastname
         $params_phone = $this->post('user_phone'); // phone = user_phone
         $device_token = $this->post('device_token'); //deviceToken = device_token
         $os_id = $this->post('os_id');
         $device_udid = $this->post('device_udid');
         $user_photo = $this->post('user_photo');
         $user_photo_ext = $this->post('user_photo_ext');
         $user_lat = $this->post('user_lat');
         $user_lng = $this->post('user_lng');
         $user_type = $this->post('user_type');
        //echo $user_photo;
        
         $user_info = array('user_firstname' => $params_firstName,
         'user_lastname' => $params_lastName,
         'user_phone' => $params_phone,
         'device_token' => $device_token,
         'os_id' => $os_id,
         'device_udid' => $device_udid,
         'user_photo' => $user_photo,
         'user_photo_ext' => $user_photo_ext,
         'user_lat' => $user_lat,
         'user_lng' => $user_lng,
         'user_type' => $user_type);

         //'user_photo' => $user_photo,
         //'user_photo_ext' => $user_photo_ext
  
        $result = $this->user_model->insertUser($user_info);
        if ($result) {
            $this->response($result, 200); // 200 being the HTTP response code
        } else {
            $this->response(NULL, 404);
        }
        
      }


      public function UserUpdate_post(){

          $this->load->model('user_model');

         $params_id = $this->post('user_id');
         $params_firstName = $this->post('user_firstname');
         $params_lastName = $this->post('user_lastname');
         $params_email = $this->post('user_email');   //email = user_email
         $params_address = $this->post('user_address');   // address = user_address

         $user_info = array('user_firstname' => $params_firstName,
         'user_lastname' => $params_lastName,
         'user_email' => $params_email,
         'user_address' => $params_address,
         'user_id' => $params_id);
  
        $result = $this->user_model->updateUser($user_info);
        if ($result) {
            $this->response($result, 200); // 200 being the HTTP response code
        } else {
            $this->response(NULL, 404);
        }
      }
      
}