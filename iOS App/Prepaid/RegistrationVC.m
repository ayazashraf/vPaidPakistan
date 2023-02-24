//
//  RegistrationVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 07/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "RegistrationVC.h"
#import "Constants.h"
#import "Base64.h"
#import "MBProgressHUD.h"
#import "UIImageView+Letters.h"
#import <AFNetworking/AFNetworking.h>
@interface RegistrationVC ()
{
    UIImagePickerController * picker2;
    NSData * profileImg;
}

@end

@implementation RegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    
    // Do any additional setup after loading the view.
    [self.nameTextField becomeFirstResponder];
    
    //
    NSString *htmlString =@"<font size=\"3\" face=\"Helvetica Neue\"><p>By pressing done button, I agree with all <a href=\"https:/www.google.com\">Terms and Conditons </a> of VPAID.</p></font>";
    [self.termsAndCondWebView loadHTMLString:htmlString baseURL:nil];
    NSData *htmlStringData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *attributedStringOptions = @{
                                              NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)
                                              };
    self.termsAndCond.attributedText = [[NSAttributedString alloc] initWithData:htmlStringData                                                                            options: attributedStringOptions                                                                 documentAttributes:nil error:nil];
    self.termsAndCond.hidden = YES;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneBtnPress:(id)sender {
    if(![self.nameTextField.text isEqualToString:@""])
    {
        [self RegistrationApiCalling];
        
        
    }
}
- (IBAction)profileImageClick:(id)sender {
    NSLog(@"i m in!");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Your Profile Picture!"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Select profile picture with using Camera", @"or using with Gallery", nil];
    actionSheet.tag = 100;
    
    [actionSheet showInView:self.view];
}
-(void)RegistrationApiCalling
{
    NSMutableDictionary * user_info = [[NSMutableDictionary alloc] init];
    [user_info setObject:self.nameTextField.text forKey:@"first_name"];
    [user_info setObject:@""forKey:@"last_name"];
    [user_info setObject:@"" forKey:@"user_email"];
    [user_info setObject:[[NSUserDefaults standardUserDefaults] valueForKey:USER_PHONE_NUM] forKey:@"user_phone_num"];
    [user_info setObject:@"" forKey:@"user_address"];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:user_info forKey:@"user_info"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    [param setValue:[user_info objectForKey:@"first_name"] forKey:@"user_firstname"];
    [param setValue:[user_info objectForKey:@"last_name"] forKey:@"user_lastname"];
    [param setValue:[user_info objectForKey:@"user_phone_num"] forKey:@"user_phone"];
    
    if([[NSUserDefaults standardUserDefaults]valueForKey:DEVICE_TOKEN])
        [param setValue:[[NSUserDefaults standardUserDefaults] valueForKey:DEVICE_TOKEN] forKey:@"device_token"];
    else
        [param setValue:@"123" forKey:@"device_token"];
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:UDID])
        [param setValue:[[NSUserDefaults standardUserDefaults] valueForKey:UDID] forKey:@"device_udid"];
    else
        [param setValue:@"456" forKey:@"device_udid"];
    
    [param setValue:@"0" forKey:@"os_id"];
    
    if(profileImg)
    {
        NSString *base64String = [profileImg base64EncodedStringWithOptions:kNilOptions];
        NSString *encodedString2 = [base64String stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [param setValue:encodedString2 forKey:@"user_photo"];
        [param setValue:@"png" forKey:@"user_photo_ext"];
        
        
    }
    else
    {
        [param setValue:@"" forKey:@"user_photo"];
        [param setValue:@"" forKey:@"user_photo_ext"];
    }
    
    
    [param setValue:[NSNumber numberWithDouble:[[[NSUserDefaults standardUserDefaults] valueForKeyPath:USER_LOCATION_LAT] doubleValue]] forKey:@"user_lat"];
    [param setValue:[NSNumber numberWithDouble:[[[NSUserDefaults standardUserDefaults] valueForKeyPath:USER_LOCATION_LNG] doubleValue]] forKey:@"user_lng"];
    
    AFHTTPSessionManager *manager =  [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //  manager.responseSerializer = [AFJS] serializer];
    [manager POST: [NSString stringWithFormat:@"%@%@", BASE_URL_VPAID_POST,USER_REGISTRATION] parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *data = (NSDictionary*)responseObject;
        if([[data valueForKey:@"status"] isEqualToString:@"OK"])
        {
            NSLog(@"JSON: %@", data);
            [[NSUserDefaults standardUserDefaults] setObject:[data valueForKey:@"user_id"] forKey:USER_ID];

            NSString *userName = @"Ahmed Shahid";
            UIImageView * imgView = [[UIImageView alloc] init];
            [imgView setImageWithString:userName color:nil circular:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error while sending data!"
                                                                message:[data valueForKey:@"status"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
        //here is place for code executed in success case
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //here is place for code executed in error case
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error while sending POST"
                                                            message:@"Sorry, try again."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        NSLog(@"Error1: %@", error);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
    
}
#pragma mark - EXTRA METHODS

-(NSString*) jsonconvert:(NSDictionary*)Dict {
    NSError *error;
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        
        NSString *Jsonstr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //  NSLog(@"%@",Jsonstr);
        return Jsonstr;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        if(buttonIndex == 0)
        {
            //open camera
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                picker2.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentModalViewController:picker2 animated:YES];
            }
            else
            {
                [[[UIAlertView alloc]initWithTitle:@"No camera found" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show ];
            }
        } else if(buttonIndex == 1)
        {
            
            // open gallery
            picker2.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentModalViewController:picker2 animated:YES];
            
        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *img =[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.profilePicImageView.image = img;
   // profileImg = (UIImageJPEGRepresentation(img,0.7));
    profileImg =(UIImagePNGRepresentation(img));
}
#pragma mark - Location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    NSMutableDictionary * locationDic = [[NSMutableDictionary alloc] init];
    [locationDic setValue:[NSNumber numberWithDouble:newLocation.coordinate.latitude] forKey:@"user_lat"];
    [locationDic setValue:[NSNumber numberWithDouble: newLocation.coordinate.longitude] forKey:@"user_lng"];
    
    [[NSUserDefaults standardUserDefaults] setObject:locationDic forKey:@"user_location"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [locationManager stopUpdatingLocation];
    
}
#pragma mark - IMAGE DOC FILE HANDLING
- (void)saveImage:(UIImage*)imageSaving :(NSString*)imageName {
    [self CreateFileFolder:@"VPAID"];
    NSData *imageData = UIImagePNGRepresentation(imageSaving); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"VPAID/%@.png", imageName]];
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
    
//    NSLog(@"image saved at path: %@", imagePathSending);
    
}
//loading an image

- (UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"VPAID/%@.png", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}
-(void)CreateFileFolder:(NSString*)folderName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:folderName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        
        NSError* error;
        if(  [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error])
            ;// success
        else
        {
            NSLog(@"[%@] ERROR: attempting to write create MyFolder directory", [self class]);
            NSAssert( FALSE, @"Failed to create directory maybe out of disk space?");
        }
    }
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
