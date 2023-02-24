<?php
require_once('../ci_vpaid/includes/config.inc.php');
//require_once('../ci_vpaid/application/config.php');
class User_model extends CI_Model{
	function __construct(){
		parent::__construct();
		$this->load->database();
	}

  function insertUser($user){  

    if (isset($user)) {
      if(empty($user['user_firstname']) ||  empty($user['user_phone'])){
        
          $status = array("status" => "Please Provide full details",
           "user_firstname" => NULL,
           "user_lastname" => NULL,
           "user_phone" => NULL);
      return $status;
        
      }
      else{
        if($user['user_photo'] != "")
        {
           $base = $user['user_photo'];
           $binary = base64_decode($base);
           $image_ext = "png";
           $image_name = md5(uniqid().rand()).'.'.$image_ext;
           $image_path ="../ci_vpaid/images/User/".$image_name;    
           $path_photo="images/User/".$image_name;
           $file = fopen($image_path, 'w');  
           fwrite($file, $binary);  
        }
        else{
          $path_photo=NULL;
        }
        $city = "";
        $state = "";
        $country = "";

        $str = @file_get_contents("http://maps.googleapis.com/maps/api/geocode/json?latlng=" . $user['user_lat'] . "," . $user['user_lng'] . "&sensor=true");
			  $data = json_decode($str, true);
			  if (isset($data["results"]) && is_array($data["results"])) {
				  $user_address = $data["results"][0]["formatted_address"];
				  $address_component = $data["results"][0]["address_components"];
				  $len = count($address_component);
				  $i = 0;
				  while ($i<$len) {
					  if (in_array("locality", $address_component[$i]["types"])){
              $city = $address_component[$i]["long_name"];
            }
            else if (in_array("administrative_area_level_1", $address_component[$i]["types"])){
              $state = $address_component[$i]["long_name"];
            } 
					  else if (in_array("country", $address_component[$i]["types"])){
              $country = $address_component[$i]["long_name"];
            } 
					  $i++;
				  }
        }

        $city_query = $this->db->query('SELECT city_id,city_name FROM `city`');
        $state_query = $this->db->query('SELECT state_id,state_name FROM `state`');
        $country_query = $this->db->query('SELECT country_id,country_name FROM `country`');

        if ($city_query->num_rows() > 0) {
		      foreach ($city_query->result() as $new_city) {
			      if (strtolower($city) == strtolower($new_city->city_name)){
              $city_id = $new_city->city_id;
            } 
		      }
		   }

       if ($state_query->num_rows() > 0) {
		      foreach ($state_query->result() as $new_state) {
			      if (strtolower($state) == strtolower($new_state->state_name)){
              $state_id = $new_state->state_id;
            }
		      }
		   }

       if ($country_query->num_rows() > 0) {
		      foreach ($country_query->result() as $new_country) {
			      if (strtolower($country) == strtolower($new_country->country_name)){
              $country_id = $new_country->country_id;
            }
		      }
		   }

       /*$query = $this->db->query('INSERT INTO `user`( `user_firstName`, `user_lastName`, `user_phone`,`user_image`,`user_lat`,`user_lng`,`user_address`,`user_city`,`user_state`,`user_country`) VALUES ('.$this->db->escape($user['user_firstname']).','.$this->db->escape($user['user_lastname']).','.$this->db->escape($user['user_phone']).','.$this->db->escape($path_photo).','.$this->db->escape($user['user_lat']).','.$this->db->escape($user['user_lng']).','.$this->db->escape($user_address).','.$this->db->escape($city_id).','.$this->db->escape($state_id).','.$this->db->escape($country_id).')');
       */

        $query = $this->db->query('INSERT INTO `user`( `user_firstName`, `user_lastName`, `user_phone`,`user_image`,`user_type`) VALUES ('.$this->db->escape($user['user_firstname']).','.$this->db->escape($user['user_lastname']).','.$this->db->escape($user['user_phone']).','.$this->db->escape($path_photo).','.$this->db->escape($user['user_type']).')');  //inserting data into user table

        $last_id = $this->db->insert_id();  //get the latest generated id(primary key) of the user i.e inserted in above query
        
        $query2 = $this->db->query('INSERT INTO `device`(`device_token`, `os_id`, `date`, `user_id`, `device_udid`) VALUES ('.$this->db->escape($user['device_token']).','.$this->db->escape($user['os_id']).',NOW(),'."$last_id".','.$this->db->escape($user['device_udid']).')');  //inserting into device table

        $query3 = $this->db->query('INSERT INTO `user_detail`( `user_id`, `user_address`, `user_city`,`user_state`,`user_country`,`user_lat`,`user_lng`,`user_image`,`user_type`,`user_email`) VALUES ('."$last_id".','.$this->db->escape($user['user_address']).','.$this->db->escape($city_id).','.$this->db->escape($state_id).','.$this->db->escape($country_id).','.$this->db->escape($user['user_lat']).','.$this->db->escape($user['user_lng']).','.$this->db->escape($path_photo).','.$this->db->escape($user['user_type']).','.$this->db->escape($user['user_email']).')');

    if($query && $query2 && $query3){
      $status = array("status" => "OK",
           "userFirstName" => $user['user_firstname'],
           "userLastName" => $user['user_lastName'],
           "userPhone" => $user['user_phone'],
           "user_id" => $last_id,
           "path_photo" => $path_photo);
      return $status;
    }
    else{  //if any of the both query fails
       $status = array("status" => "Query Failed",
            "user_firstname" => NULL,
           "user_lastname" => NULL,
           "user_phone" => NULL);
      return $status;
    }

    
    }
      
    }
    else{  //if the fields are not set
      $status = array("status" => "Field Not Set",
           "user_firstname" => NULL,
           "user_lastname" => NULL,
           "user_phone" => NULL);
      return $status;
    }
    
  }

  function updateUser($user){
    if (isset($user)) {
      if($user['user_firstname']!=NULL && $user['user_lastname']!=NULL && $user['user_email']!=NULL && $user['user_address']!=NULL){
        
        $query = $this->db->query('UPDATE `user` SET user_firstName='.$this->db->escape($user['user_firstname']).', user_lastName='.$this->db->escape($user['user_lastname']).', user_email='.$this->db->escape($user['user_email']).', user_address='.$this->db->escape($user['user_address']).' WHERE user_id='.$user['user_id'].' ');
        if($query){
          $status = array("status" => "OK",
             "user_firstname" => $user['user_firstname'],
             "user_lastname" => $user['user_lastname'],
             "user_email" => $user['user_email'],
             "user_address" => $user['user_address']);
        return $status;
        }
        else{
           $status = array("status" => "Query Failed",
               "user_firstname" => NULL,
               "user_lastname" => NULL,
               "user_email" => NULL,
               "user_address" => NULL);
          return $status;
        }
      }

      else{ //not ok. We have to make sure the data will be saved as previously stored if any variable is null
        if($user['user_firstname'] == NULL){
          $query = $this->db->query('UPDATE `user` SET user_lastName='.$this->db->escape($user['user_lastname']).', user_email='.$this->db->escape($user['user_email']).', user_address='.$this->db->escape($user['user_address']).' WHERE user_id='.$user['user_id'].' ');
          if($query){
            $status = array("status" => "OK",
               "user_firstname" => $user['user_firstname'],
               "user_lastname" => $user['user_lastname'],
               "user_email" => $user['user_email'],
               "user_address" => $user['user_address']);
          return $status;
          }
          else{
             $status = array("status" => "Query Failed",
                 "user_firstname" => NULL,
                 "user_lastname" => NULL,
                 "user_email" => NULL,
                 "user_address" => NULL);
            return $status;
          }
        }
        elseif ($user['user_lastname'] == NULL) {

          $query = $this->db->query('UPDATE `user` SET user_firstName='.$this->db->escape($user['user_firstname']).', user_email='.$this->db->escape($user['user_email']).', user_address='.$this->db->escape($user['user_address']).' WHERE user_id='.$user['user_id'].' ');
          if($query){
            $status = array("status" => "OK",
               "user_firstname" => $user['user_firstname'],
               "user_lastname" => $user['user_lastname'],
               "user_email" => $user['user_email'],
               "user_address" => $user['user_address']);
          return $status;
          }
          else{
             $status = array("status" => "Query Failed",
                 "user_firstname" => NULL,
                 "user_lastname" => NULL,
                 "user_email" => NULL,
                 "user_address" => NULL);
            return $status;
          }
        }

        elseif ($user['user_email'] == NULL){
           $query = $this->db->query('UPDATE `user` SET user_firstName='.$this->db->escape($user['user_firstname']).', user_lastName='.$this->db->escape($user['user_lastname']).', user_address='.$this->db->escape($user['user_address']).' WHERE user_id='.$user['user_id'].' ');
          if($query){
            $status = array("status" => "OK",
               "user_firstname" => $user['user_firstname'],
               "user_lastname" => $user['user_lastname'],
               "user_email" => $user['user_email'],
               "user_address" => $user['user_address']);
          return $status;
          }
          else{
             $status = array("status" => "Query Failed",
                 "user_firstname" => NULL,
                 "user_lastname" => NULL,
                 "user_email" => NULL,
                 "user_address" => NULL);
            return $status;
          }
        }

        elseif ($user['user_address'] == NULL) {
          $query = $this->db->query('UPDATE `user` SET user_firstName='.$this->db->escape($user['user_firstname']).', user_lastName='.$this->db->escape($user['user_lastname']).' WHERE user_id='.$user['user_id'].' ');
          if($query){
            $status = array("status" => "OK",
               "user_firstname" => $user['user_firstname'],
               "user_lastname" => $user['user_lastname'],
               "user_email" => $user['user_email'],
               "user_address" => $user['user_address']);
          return $status;
          }
          else{
             $status = array("status" => "Query Failed",
                 "user_firstname" => NULL,
                 "user_lastname" => NULL,
                 "user_email" => NULL,
                 "user_address" => NULL);
            return $status;
          }
        }

      }
      
    }
    else{
      $status = array("status" => "Field Not Set",
           "user_firstname" => NULL,
           "user_lastname" => NULL,
           "user_email" => NULL,
           "user_address" => NULL);
      return $status;
    }
  }
}
?>
