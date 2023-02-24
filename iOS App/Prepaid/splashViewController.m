//
//  ViewController.m
//  Prepaid
//
//  Created by Ahmed Shahid on 02/08/2016.
//  Copyright © 2016 Foreign Tree System. All rights reserved.
//

#import "splashViewController.h"
#import "LoginViewController.h"
#import "MainHomeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setHidden:YES];
//    self.navigationItem.hidesBackButton = YES; //these above lines will hide the nevigation bar
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"userPhoneNumber"]) {
        // if user have already login, navigate him to mainHomeVC
    [self performSelector:@selector(navigateToMainHomeVC) withObject:nil afterDelay:2.0];
    }
    else
        //else navigate him to loginVC
    [self performSelector:@selector(navigateToLoginVC) withObject:nil afterDelay:2.0];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) navigateToLoginVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        LoginViewController* loginVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.navigationController pushViewController: loginVC  animated:YES];
    });
}

- (void) navigateToMainHomeVC
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MainHomeViewController* mainHomeVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"mainHomeVC"];
        [self.navigationController pushViewController: mainHomeVC  animated:YES];
    });
}

@end
