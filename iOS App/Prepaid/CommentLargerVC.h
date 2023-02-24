//
//  CommentLargerVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@interface CommentLargerVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *foregroundView;
@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property(strong, nonnull) NSDictionary * author_dict;
@property (strong, nonatomic) IBOutlet UIImageView *author_img;
- (IBAction)closeBtnTouch:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *author_name;
@property (strong, nonatomic) IBOutlet UILabel *author_comment_time;
@property (strong, nonatomic) IBOutlet UITextView *author_text;
@property (strong, nonatomic) IBOutlet ASStarRatingView *ratingView;
-(void) setScreen;
@end
