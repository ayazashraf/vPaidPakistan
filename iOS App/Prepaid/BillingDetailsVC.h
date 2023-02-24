//
//  BillingDetailsVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 20/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerVC.h"
#import "DownPicker.h"
@interface BillingDetailsVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *dateAndTimeLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *payBtn;
@property (strong, nonatomic) IBOutlet UITextField *noOfGuestTextField;

@property(strong, nonatomic) DatePickerVC *datePickerVC;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *drawerBtn;
@property (strong, nonatomic) DownPicker *noOfGuestDropDown;
@end
