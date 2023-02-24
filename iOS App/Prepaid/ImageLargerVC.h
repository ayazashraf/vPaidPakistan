//
//  ImageLargerVC.h
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLargerVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *foregroundView;

@property (strong, nonatomic) IBOutlet UIImageView *bg;
@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property(strong, nonnull) NSURL * imageUrl;
- (IBAction)closeBtnTouch:(id)sender;
-(void) setScreen;
@end
