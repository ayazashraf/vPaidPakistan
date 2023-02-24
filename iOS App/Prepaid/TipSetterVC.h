//
//  TipSetterVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 13/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipSetterVC : UIViewController
{
    NSUInteger tipAmount;
}
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *foregroundView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;

- (IBAction)closeBtnTouch:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tipTextField;


@property (strong, nonatomic) IBOutlet UIButton *TipAddBtn;
@property (strong, nonatomic) IBOutlet UIButton *TipMinusBtn;
-(void) setScreen;
@end
