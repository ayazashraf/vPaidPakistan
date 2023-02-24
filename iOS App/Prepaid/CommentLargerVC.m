//
//  CommentLargerVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "CommentLargerVC.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/CALayer.h>
//#import <SDWebImage/UIImageView+WebCache.h>
@interface CommentLargerVC ()

@end

@implementation CommentLargerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize bg;
-(void) setScreen
{    UIImage *image = [UIImage convertViewToImage];
    UIImage *blurSnapshotImage = nil;
    blurSnapshotImage = [image applyBlurWithRadius:5.0
                                         tintColor:[UIColor colorWithWhite:0.2
                                                                     alpha:0.7]
                             saturationDeltaFactor:1.8
                                         maskImage:nil];
    
    bg.image = blurSnapshotImage;
    bg.alpha = 1.0;
    self.author_name.text = [self.author_dict valueForKey:@"author_name"];
        self.author_text.text = [self.author_dict valueForKey:@"text"];
    self.author_comment_time.text =  [self.author_dict valueForKey:@"relative_time_description"];
   // [self.author_img sd_setImageWithURL:[NSURL URLWithString: [self.author_dict valueForKey:@"profile_photo_url"]] placeholderImage:nil];
    self.ratingView.canEdit = NO;
    self.ratingView.maxRating = 5;
    
    self.ratingView.rating = [[self.author_dict valueForKey:@"rating"] doubleValue];
    

    self.foregroundView.layer.cornerRadius = 7;
    self.foregroundView.layer.masksToBounds = YES;


}

- (IBAction)closeBtnTouch:(id)sender {
    
}
- (IBAction)profileBtnClick:(id)sender {
    
    //
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.author_dict valueForKey:@"author_url"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
