//
//  ProfileVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 24/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "ProfileVC.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "SWRevealViewController.h"
#import "iToast.h"

@interface ProfileVC ()
{
    BOOL isAllowEdit;
}
  @property UITapGestureRecognizer *singleFingerTap;
@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleFingerTap];
    self.singleFingerTap.enabled = NO;

    [self PopulateDataFromDefaults];
    isAllowEdit = YES;
    _doneBarBtnItm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editBtnPress:)];
    self.doneBarBtnItm.tintColor = [UIColor blackColor];
    self.addressTextView.layer.cornerRadius = 5;
    self.addressTextView.layer.borderWidth = 0.5;
    self.addressTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    self.firstNameLabel.delegate = self;
    self.lastNameLabel.delegate = self;
    self.emailLabel.delegate = self;
    self.addressTextView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editBtnPress:(id)sender {
    if(isAllowEdit)
    {
        // When Edit Press
        [self isAllowEditing:isAllowEdit];
        isAllowEdit = NO;
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
        [self.navigationItem setRightBarButtonItem:self.doneBarBtnItm animated:YES];
        
    }
    else
    {
        //When Done Press
        [self isAllowEditing:isAllowEdit];
        isAllowEdit = YES;
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
        [self.navigationItem setRightBarButtonItem:self.editBarBtnItm animated:YES];
        
        [self SaveInfo];
    }
    
}

-(void)isAllowEditing:(BOOL)yes
{
    if(yes)
    {
        self.firstNameLabel.userInteractionEnabled = YES;
        self.lastNameLabel.userInteractionEnabled = YES;
        self.emailLabel.userInteractionEnabled = YES;
        self.addressTextView.userInteractionEnabled = YES;
        
        self.firstNameLabel.textColor = [UIColor blackColor];
        self.lastNameLabel.textColor = [UIColor blackColor];
        self.emailLabel.textColor = [UIColor blackColor];
        self.addressTextView.textColor = [UIColor blackColor];
        
    }
    else
    {
        self.firstNameLabel.userInteractionEnabled = NO;
        self.lastNameLabel.userInteractionEnabled = NO;
        self.emailLabel.userInteractionEnabled = NO;
        self.addressTextView.userInteractionEnabled = NO;
        
        self.firstNameLabel.textColor = [UIColor lightGrayColor];
        self.lastNameLabel.textColor = [UIColor lightGrayColor];
        self.emailLabel.textColor = [UIColor lightGrayColor];
        self.addressTextView.textColor = [UIColor lightGrayColor];
    }
}

-(void)SaveInfo
{
    NSMutableDictionary * user_info = [[NSMutableDictionary alloc] init];
    [user_info setObject:self.firstNameLabel.text forKey:@"first_name"];
    [user_info setObject:self.lastNameLabel.text forKey:@"last_name"];
    [user_info setObject:self.emailLabel.text forKey:@"user_email"];
    [user_info setObject:self.addressTextView.text forKey:@"user_address"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:user_info forKey:@"user_info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:[[NSUserDefaults standardUserDefaults] valueForKey:USER_ID] forKey:@"user_id"];
    [param setValue:[user_info objectForKey:@"first_name"] forKey:@"user_firstname"];
    [param setValue:[user_info objectForKey:@"last_name"] forKey:@"user_lastname"];
    [param setValue:[user_info objectForKey:@"user_email"] forKey:@"user_email"];
    [param setValue:[user_info objectForKey:@"user_address"] forKey:@"user_address"];

    NSLog(@"param = %@", param);
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST: [NSString stringWithFormat:@"%@%@", BASE_URL_VPAID_POST,USER_INFO_UPDATE] parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *data = (NSDictionary*)responseObject;
        if([[data valueForKey:@"status"] isEqualToString:@"OK"])
        {
            NSLog(@"JSON: %@", data);
            [[[iToast makeText:@"Your info has  Updated Sucessfully!"] setDuration:iToastDurationNormal] show];
        }
        else
        {
            [[[iToast makeText:@"Error while sending data!"] setDuration:iToastDurationNormal] show];
        }
        
        //here is place for code executed in success case
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //here is place for code executed in error case
        [[[iToast makeText:NO_INTERNET_CONN] setDuration:iToastDurationNormal] show];
        NSLog(@"Error1: %@", error);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];

}

-(void)PopulateDataFromDefaults
{
    self.phoneNumLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:USER_PHONE_NUM];
    if([[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_info"])
    {
        NSDictionary * user_info = [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_info"]];
        self.firstNameLabel.text = [user_info valueForKey:@"first_name"];
        self.lastNameLabel.text = [user_info valueForKey:@"last_name"];
        self.emailLabel.text = [user_info valueForKey:@"user_email"];
        self.addressTextView.text = [user_info valueForKey:@"user_address"];;
    }
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    self.singleFingerTap.enabled = NO;
    [self.firstNameLabel resignFirstResponder];
    [self.lastNameLabel resignFirstResponder];
    [self.emailLabel resignFirstResponder];
    [self.addressTextView resignFirstResponder];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.singleFingerTap.enabled = YES;
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
