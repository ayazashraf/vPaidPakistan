//
//  MainHomeViewController.m
//  Prepaid
//
//  Created by Ahmed Shahid on 04/08/2016.
//  Copyright © 2016 Foreign Tree System. All rights reserved.
//

#import "MainHomeViewController.h"
#import "WebRequest.h"
//#import "iToast.h"
#import "MainHomeTableViewCell.h"
#import "MenuAndDetailVC.h"
#import "SWRevealViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RegistrationVC.h"
#import "Constants.h"
#import "iToast.h"
@interface MainHomeViewController ()
@property NSMutableArray* ResturantDataArray;
@property UITapGestureRecognizer *singleFingerTap;
@end

@implementation MainHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if(![[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user_info"])
    {
        RegistrationVC * rVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationVC"];
        [self presentViewController:rVC animated:YES completion:nil];
    }
    [self initData];
    //[self getResturantDataForHomePage];
    self.singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:self.singleFingerTap];
   self.singleFingerTap.enabled = NO;
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.navigationController.navigationBar.barTintColor = [self colorWithHexString:@"CCCCCC"];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.hidesBackButton = YES;
    self.searchBarVIew = [[UISearchBar alloc] init];
    [self.searchBarVIew setPlaceholder:@"Search"];
    self.navigationItem.titleView = self.searchBarVIew;
    self.searchBarVIew.delegate = self;
}

-(void)initData
{
    _ResturantDataArray = [[NSMutableArray alloc] init];
    // for(int i = 0; i < 2; i++)
    // {
    NSMutableDictionary * dicTemp1 = [[NSMutableDictionary alloc] init];
    [dicTemp1 setValue:@"KFC" forKey:@"places_name"];
    [dicTemp1 setValue:@"Rashid Minhas Road, Karachi" forKey:@"places_location"];
    [dicTemp1 setValue:@"kfcLogo1" forKey:@"places_image"];
   // [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
   // [dicTemp1 setValue:@"01" forKey:@"item_id"];
    [_ResturantDataArray addObject:dicTemp1];
    
    NSMutableDictionary * dicTemp2 = [[NSMutableDictionary alloc] init];
    [dicTemp2 setValue:@"Burger King" forKey:@"places_name"];
    [dicTemp2 setValue:@"Dolmen Mall Clifton, Karachi" forKey:@"places_location"];
    [dicTemp2 setValue:@"burgerKing" forKey:@"places_image"];
    //[dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
    //[dicTemp2 setValue:@"02" forKey:@"item_id"];
    [_ResturantDataArray addObject:dicTemp2];
    
//    NSMutableDictionary * dicTemp3 = [[NSMutableDictionary alloc] init];
//    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos" forKey:@"item_name"];
//    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
//    [dicTemp3 setValue:@"150" forKey:@"item_price"];
//    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
//    [dicTemp3 setValue:@"03" forKey:@"item_id"];
//    [_item_details addObject:dicTemp3];
//    
//    dicTemp1 = [[NSMutableDictionary alloc] init];
//    [dicTemp1 setValue:@"Brekkie Crunch Wrap 2" forKey:@"item_name"];
//    [dicTemp1 setValue:@"Beef cooked in a pastry crunch" forKey:@"item_detail"];
//    [dicTemp1 setValue:@"240" forKey:@"item_price"];
//    [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
//    [dicTemp1 setValue:@"04" forKey:@"item_id"];
//    
//    [_item_details addObject:dicTemp1];
//    
//    dicTemp2 = [[NSMutableDictionary alloc] init];
//    [dicTemp2 setValue:@"Chilli Twist 2" forKey:@"item_name"];
//    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_detail"];
//    [dicTemp2 setValue:@"150" forKey:@"item_price"];
//    [dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
//    [dicTemp2 setValue:@"05" forKey:@"item_id"];
//    [_item_details addObject:dicTemp2];
//    
//    dicTemp3 = [[NSMutableDictionary alloc] init];
//    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos 2" forKey:@"item_name"];
//    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
//    [dicTemp3 setValue:@"150" forKey:@"item_price"];
//    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
//    [dicTemp3 setValue:@"06" forKey:@"item_id"];
//    [_item_details addObject:dicTemp3];
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
#pragma mark - API CALLING
- (void)getResturantDataForHomePage
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *string = [NSString stringWithFormat:@"%@%@", BASE_URL_VPAID_POST, GET_PLACES];
    NSURL *url = [NSURL URLWithString:string];
    NSLog(@"MainHomeViewController: %@", url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *data = (NSDictionary*)responseObject;
            NSString *checkError = [data valueForKey:@"error"];
            if([checkError integerValue] == 0){
                // NSDictionary *responseData = [data valueForKey:@"results"];
                if([[data valueForKey:@"status"] isEqualToString:@"OK"])
                {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    _ResturantDataArray = [[NSMutableArray alloc] initWithArray:[data valueForKey:@"places"]];
                    [self.TableView reloadData];
                }
            }
            else{
                  [[[iToast makeText:@"internal server error..."] setDuration:iToastDurationNormal] show];
            }
            
        }else if ([responseObject isKindOfClass:[NSArray class]]){
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [[[iToast makeText:@"I m in Array"] setDuration:iToastDurationNormal] show];

        }
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"Error: %@", error);
             [[[iToast makeText:@"No internet connection! Try again later."] setDuration:iToastDurationNormal] show];
         }];
}
#pragma mark - UITABLEVIEW DATASOURVE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ResturantDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //MainHomeTableViewCell
    static NSString *simpleTableIdentifier = @"MainHomeTableViewCell";
    
    MainHomeTableViewCell *cell = (MainHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MainHomeTableViewCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainHomeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.ResturantName.text = [[self.ResturantDataArray objectAtIndex:indexPath.row] valueForKey:@"places_name"]; //
    cell.ResturantAddress.text = [[self.ResturantDataArray objectAtIndex:indexPath.row] valueForKey:@"places_location"];
    NSString * url = [NSString stringWithFormat:@"%@%@", IMAGES_BASE_URL_VPAID, [[self.ResturantDataArray objectAtIndex:indexPath.row] valueForKey:@"places_image"]];
    [cell.ResturantLogo sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    cell.ResturantLogo.image = [UIImage imageNamed: [[self.ResturantDataArray objectAtIndex:indexPath.row] valueForKey:@"places_image"]];
    return cell;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MainHomeTableViewCell *cell = (MainHomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self.revealViewController rightRevealToggleAnimated:YES];
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    MenuAndDetailVC * madVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuAndDetailVC"];
    madVC.title_of_resturant = [[self.ResturantDataArray objectAtIndex:indexPath.row] valueForKey:@"places_name"];
    madVC.placesDetails = [self.ResturantDataArray objectAtIndex:indexPath.row];
    madVC.resuturantImage = cell.ResturantLogo.image;
    [self.navigationController pushViewController:madVC animated:YES];
}
#pragma mark - UISEARCHBAR DELEGATE
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.singleFingerTap.enabled = YES;
}
//The event handling method
#pragma mark - UITapGestureRecognizer DELEGATE
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    //Do stuff here...
    self.singleFingerTap.enabled = NO;
    [self.searchBarVIew resignFirstResponder];
    [self.searchBarVIew setText:@""];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
