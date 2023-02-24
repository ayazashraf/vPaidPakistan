//
//  DatePickerVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 18/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerVC : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *foregroundView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
//@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
//- (IBAction)closeBtnTouch:(id)sender;



-(void) setScreen;
@end
