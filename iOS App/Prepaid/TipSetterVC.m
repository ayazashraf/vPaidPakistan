//
//  TipSetterVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 13/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "TipSetterVC.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/CALayer.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface TipSetterVC ()
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation TipSetterVC




@synthesize bg;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setScreen
{
    self.singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleFingerTap];
    self.singleFingerTap.enabled = NO;
    tipAmount = 50;
    _foregroundView.layer.cornerRadius = 5;
    _foregroundView.layer.borderWidth = 0.5;
    _foregroundView.layer.borderColor = [UIColor blackColor].CGColor;
    UIImage *image = [UIImage convertViewToImage];
    UIImage *blurSnapshotImage = nil;
    blurSnapshotImage = [image applyBlurWithRadius:5.0
                                         tintColor:[UIColor colorWithWhite:0.2
                                                                     alpha:0.7]
                             saturationDeltaFactor:1.8
                                         maskImage:nil];
    
    bg.image = blurSnapshotImage;
    bg.alpha = 1.0;
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    self.singleFingerTap.enabled = NO;
    [self.tipTextField resignFirstResponder];
}
- (IBAction)closeBtnTouch:(id)sender {
    
}
- (IBAction)tipMinus:(id)sender {
    if(tipAmount > 10)
    {
        tipAmount -= 10;
        self.tipTextField.text = [NSString stringWithFormat:@"Rs %lu", (unsigned long)tipAmount];
    }
}
- (IBAction)tipAdd:(id)sender {
    tipAmount += 10;
    self.tipTextField.text = [NSString stringWithFormat:@"Rs %lu", (unsigned long)tipAmount];
}
- (IBAction)textFeildEditingDidBegin:(id)sender {
        self.singleFingerTap.enabled = YES;
    self.TipAddBtn.enabled = NO;
    self.TipMinusBtn.enabled = NO;
    self.closeBtn.enabled = NO;
    self.tipTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)tipAmount];
    
}
- (IBAction)textFeildEditingDidEnd:(id)sender {
    if([self.tipTextField.text integerValue] < 10)
        self.tipTextField.text = @"10";
    self.TipAddBtn.enabled = YES;
    self.TipMinusBtn.enabled = YES;
    self.closeBtn.enabled = YES;
    tipAmount = [self.tipTextField.text integerValue];
     self.tipTextField.text = [NSString stringWithFormat:@"Rs %@", self.tipTextField.text];
}
@end
