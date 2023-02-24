//
//  BillingDetailsVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 20/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "BillingDetailsVC.h"
#import "DatePickerVC.h"
#import "SWRevealViewController.h"
@interface BillingDetailsVC ()
{

}

@end

@implementation BillingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [self AddStyle:self.dateAndTimeLabel];
    [self AddStyle:self.descriptionTextView];
     self.payBtn.layer.cornerRadius = 5;
    
    // create the array of data
    NSMutableArray* bandArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < 10; i++)
    {
        if(i == 0)
            [bandArray addObject:[NSString stringWithFormat:@"%d Person", i + 1]];
        else
            [bandArray addObject:[NSString stringWithFormat:@"%d Persons", i + 1]];
    }
    
     SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // bind yourTextField to DownPicker
    self.noOfGuestDropDown = [[DownPicker alloc] initWithTextField:self.noOfGuestTextField withData:bandArray];
    [self.noOfGuestDropDown addTarget:self
                            action:@selector(dp_Selected:)
                  forControlEvents:UIControlEventValueChanged];
    self.noOfGuestTextField.text = @"No Of Guests";
    self.noOfGuestTextField.textColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view.
}
-(void)dp_Selected:(id)dp {
    NSString* selectedValue = [self.noOfGuestDropDown text];
    self.noOfGuestTextField.textColor = [UIColor blackColor];
    // do what you want
}
-(void)AddStyle:(UIView*)view
{
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [self colorWithHexString:@"CCCCCC"].CGColor;
    view.layer.cornerRadius = 5;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calendarBtnPress:(id)sender {
    _datePickerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DatePickerVC"];
    _datePickerVC.view.frame = self.view.frame;
    
    [_datePickerVC.closeBtn addTarget:self action:@selector(closeBuyNow) forControlEvents:UIControlEventTouchUpInside];
   // imageLargerView.showImage.image = [self loadImage:[[chatHistory objectAtIndex:buttonTagIndex] valueForKey:@"chat_details_media"]];
    [_datePickerVC setScreen];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_datePickerVC.view];

    
}
-(void)closeBuyNow
{
    self.dateAndTimeLabel.textColor = [UIColor blackColor];
    NSDate * newDate =  [self.datePickerVC.datePicker.date dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT]/*+3600 * 5*/];
    
    
    
    NSDateFormatter *dateformate=[[NSDateFormatter alloc]init];
    dateformate.dateFormat = @"EEEE dd-MMM-yyyy hh:mm a"; // Date formater
    NSString *timeString = [dateformate stringFromDate:self.datePickerVC.datePicker.date];
    
    
    
    
    self.dateAndTimeLabel.text = [NSString stringWithFormat:@"   %@", timeString];
    [self.datePickerVC.view removeFromSuperview];
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
