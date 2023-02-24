//
//  ProfileVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 24/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;
@property (strong, nonatomic) IBOutlet UITextField *addressTextView;
@property (strong, nonatomic) IBOutlet UITextField *firstNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *lastNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarBtnItm;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarBtnItm;

@end
