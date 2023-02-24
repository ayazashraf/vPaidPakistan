//
//  LoginViewController.m
//  Prepaid
//
//  Created by Ahmed Shahid on 03/08/2016.
//  Copyright © 2016 Foreign Tree Systems. All rights reserved.
//

#import "LoginViewController.h"
#import <DigitsKit/DigitsKit.h> // digits by twitter's kit
#import "MainHomeViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "Constants.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"Prepaid";
    self.navigationItem.hidesBackButton = YES; //this lines will hide navigation bar back button, so user can't go back to the splash screen again...
    /*
     * Code for Phone number verification
     */
    if([[NSUserDefaults standardUserDefaults] valueForKey:USER_PHONE_NUM])
    {
        SWRevealViewController* swRevealVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        // [self.navigationController pushViewController: mainHomeVC  animated:YES];// navigate him towards mainHomeVC
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        app.window.rootViewController = swRevealVC;
        
    }
    else
    {
        DGTAuthenticateButton *authButton;
        authButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
            if (session.userID) {
                [[NSUserDefaults standardUserDefaults] setObject:session.phoneNumber forKey:USER_PHONE_NUM];
                [[NSUserDefaults standardUserDefaults] synchronize]; // storing user phone number for future use
                NSLog(@"I m using phone num: %@", session.phoneNumber);
                SWRevealViewController* swRevealVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                app.window.rootViewController = swRevealVC;
            } else if (error) {
                NSLog(@"Authentication error: %@", error.localizedDescription);
            }
        }];
        
        
        authButton.center = self.view.center;
        //authButton.digitsAppearance = [self makeTheme]; // uncomment if you want to use login button styling
        [self.view addSubview:authButton]; // showing authButton
        // Do any additional setup after loading the view.
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * method for styling lgoin button
 */
- (DGTAppearance *)makeTheme {
    DGTAppearance *theme = [[DGTAppearance alloc] init];
    theme.bodyFont = [UIFont fontWithName:@"Noteworthy-Light" size:16];
    theme.labelFont = [UIFont fontWithName:@"Noteworthy-Bold" size:17];
    theme.accentColor = [UIColor lightGrayColor];//[UIColor colorWithRed:(255.0/255.0) green:(172/255.0) blue:(238/255.0) alpha:1];
    theme.backgroundColor = [UIColor colorWithRed:(240.0/255.0) green:(255/255.0) blue:(250/255.0) alpha:1];
    // TODO: Set a UIImage as a logo with theme.logoImage
    return theme;
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
