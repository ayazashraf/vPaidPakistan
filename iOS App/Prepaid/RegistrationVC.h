//
//  RegistrationVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 07/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface RegistrationVC : UIViewController<UIImagePickerControllerDelegate, CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}


@property (strong, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *termsAndCond;

@property (strong, nonatomic) IBOutlet UIWebView *termsAndCondWebView;

@end
