//
//  ImageLargerVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 31/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "ImageLargerVC.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/CALayer.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface ImageLargerVC ()

@end

@implementation ImageLargerVC

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
{
    UIImage *image = [UIImage convertViewToImage];
    UIImage *blurSnapshotImage = nil;
    blurSnapshotImage = [image applyBlurWithRadius:5.0
                                         tintColor:[UIColor colorWithWhite:0.2
                                                                     alpha:0.7]
                             saturationDeltaFactor:1.8
                                         maskImage:nil];
    
    bg.image = blurSnapshotImage;
    bg.alpha = 1.0;
    

    self.showImage.layer.cornerRadius = 10;
    self.showImage.layer.masksToBounds = YES;
}

- (IBAction)closeBtnTouch:(id)sender {
    
}



@end
