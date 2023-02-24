//
//  DatePickerVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 18/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "DatePickerVC.h"
#import "UIImage+ImageEffects.h"
@interface DatePickerVC ()

@end

@implementation DatePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)doneBtnPress:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@synthesize bg;
- (id)initWithFrame:(CGRect)frame
{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        
//        
//        
//    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(void) setScreen
{
    //bg = [[UIImageView alloc]initWithFrame:[self mainScreenFrame]];
    self.datePicker.minimumDate = [[NSDate date] dateByAddingTimeInterval:3600 * 1];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSDate *MaxDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    self.datePicker.maximumDate = MaxDate;
    UIImage *image = [UIImage convertViewToImage];
    UIImage *blurSnapshotImage = nil;
    blurSnapshotImage = [image applyBlurWithRadius:5.0
                                         tintColor:[UIColor colorWithWhite:0.2
                                                                     alpha:0.7]
                             saturationDeltaFactor:1.8
                                         maskImage:nil];
    
    bg.image = blurSnapshotImage;
    bg.alpha = 1.0;
    
    
    //[self.BuyNowView setHidden:NO];
    //[self bringSubviewToFront:self.BuyNowView];
}

//- (IBAction)closeBtnTouch:(id)sender {
//    [self.view removeFromSuperview];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
