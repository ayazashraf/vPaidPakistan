//
//  Constants.h
//  Prepaid
//
//  Created by Ahmed Shahid on 05/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define GOOGLE_API_KEY @"AIzaSyAhnBc9DEDhOkNn0hGJ9E7FobsEFRv-ph0"
#pragma mark - BASE URL
#define BASE_URL_VPAID @"http://192.168.1.11/ci_vpaid/apis/"
#define BASE_URL_VPAID_POST @"http://192.168.1.11/ci_vpaid_workingcopy/index.php/"
#define IMAGES_BASE_URL_VPAID @"http://192.168.1.11/ci_vpaid_workingcopy/"

#pragma mark - APIS
#define GOOGLE_TRACK_LOCATION_BASE_URL @"https://maps.googleapis.com/maps/api/directions/json?"
#define GET_PLACES @"PlacesController/Places"
#define USER_REGISTRATION @"UserController/User"
#define USER_INFO_UPDATE @"UserController/UserUpdate"
#define GET_PRODUCTS @"ProductController/Products?"

#pragma mark - USERDEFAULTS KEYS
#define DEVICE_TOKEN @"DEVICE_TOKEN"
#define USER_PHONE_NUM @"userPhoneNumber"
#define UDID @"DeviceUDID"
#define USER_ID @"user_id"
#define USER_LOCATION_LAT @"user_location.user_lat"
#define USER_LOCATION_LNG @"user_location.user_lng"

#pragma mark - ERROR MESSAGES
#define NO_INTERNET_CONN @"No Internet Connection! Try Again Later"
#endif /* Constants_h */

/// svn checking...
