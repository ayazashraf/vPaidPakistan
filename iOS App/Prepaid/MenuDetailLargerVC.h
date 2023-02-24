//
//  MenuDetailLargerVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 21/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface MenuDetailLargerVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *foregroundView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property(strong, nonnull) NSURL * imageUrl;
- (IBAction)closeBtnTouch:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *fg_price;
@property (strong, nonatomic) IBOutlet UIImageView *fg_image;
@property (strong, nonatomic) IBOutlet UIButton *fg_cart_btn;
@property (strong, nonatomic) IBOutlet UITextView *fg_description;
@property (strong, nonatomic) IBOutlet UILabel *fg_name;

@property (strong, nonatomic) NSDictionary * item_dic;
-(void) setScreen;
@end
