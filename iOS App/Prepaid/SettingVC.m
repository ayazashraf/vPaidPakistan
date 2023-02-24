//
//  SettingVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 06/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "SettingVC.h"
#import "SWRevealViewController.h"
#import "AccountAndAboutTVC.h"
@interface SettingVC ()
{
    NSArray * menuItems;
}

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"pushNotificationId", @"locationUsageId", @"accountId", @"setYourDefaultTip", @"aboutAndHelpId", @"tellAFriendId", @"facebookCellId", @"twitterCellId", @"resetAllCellId"];
    for(int i = 0; i < menuItems.count; i++)
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[menuItems objectAtIndex:i]];
    
      SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -UITABLEVIEW DATASOURCE
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//     NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
//    if(indexPath.section == 0 && indexPath.row == 0)
//    {
//         CellIdentifier = @"pushNotificationId";
//    }
//    else if(indexPath.section == 0 && indexPath.row == 1)
//    {
//        CellIdentifier = @"locationUsageId";
//    }
//    else if(indexPath.section == 1 && indexPath.row == 0)
//    {
//        CellIdentifier = @"accountId";
//    }
//    else if(indexPath.section == 1 && indexPath.row == 1)
//    {
//        CellIdentifier = @"setYourDefaultTip";
//    }
//    else if(indexPath.section == 2 && indexPath.row == 0)
//    {
//        CellIdentifier = @"aboutAndHelpId";
//    }
//    else if(indexPath.section == 2 && indexPath.row == 1)
//    {
//        CellIdentifier = @"tellAFriendId";
//    }
//    else if(indexPath.section == 2 && indexPath.row == 2)
//    {
//        CellIdentifier = @"facebookCellId";
//    }
//    else if(indexPath.section == 2 && indexPath.row == 3)
//    {
//        CellIdentifier = @"twitterCellId";
//    }
//    else if(indexPath.section == 3 && indexPath.row == 0)
//    {
//        CellIdentifier = @"resetAllCellId";
//    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    return cell;
//}

#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1 && indexPath.row == 0) // account Click
    {
        AccountAndAboutTVC * aaaTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountAndAboutTVC"];
        aaaTVC.tableViewCode = @"0";
        [self.navigationController pushViewController:aaaTVC animated:YES];
    }
    else if(indexPath.section == 1 && indexPath.row == 1) // Set your default tip click
    {
        [self ShowTipSetter];
    }
    else if(indexPath.section == 2 && indexPath.row == 0) // about and help Click
    {
        AccountAndAboutTVC * aaaTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountAndAboutTVC"];
        aaaTVC.tableViewCode = @"1";
        [self.navigationController pushViewController:aaaTVC animated:YES];
    }
    else if(indexPath.section == 2 && indexPath.row == 1) // Tell a Friend Click
    {
        NSString *title = @"VPAID";
        NSURL *event_url = [NSURL URLWithString:@"https://www.google.com.pk"];
        UIImage * event_cover = [UIImage imageNamed:@"kfcLogo1"];
        NSArray *objectsToShare = @[title, event_url, event_cover];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems: objectsToShare applicationActivities:nil];
        
        NSArray *excludeActivities = @[/*UIActivityTypeAirDrop,
                                        UIActivityTypeCopyToPasteboard,
                                        UIActivityTypePrint,
                                        UIActivityTypeAssignToContact,
                                        UIActivityTypeSaveToCameraRoll,
                                        UIActivityTypeAddToReadingList,
                                        UIActivityTypePostToFlickr,
                                        UIActivityTypePostToVimeo,*/
                                       ];
        activityVC.excludedActivityTypes = excludeActivities;
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    else if(indexPath.section == 2 && indexPath.row == 2) // facebook Click
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com"]];
    }
    else if(indexPath.section == 2 && indexPath.row == 3) // twitter Click
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com"]];
    }
    
}
-(void)ShowTipSetter
{
    self.tsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TipSetterVC"];
    self.tsVC.view.frame = self.view.frame;
    [self.tsVC.closeBtn addTarget:self action:@selector(closeTipSetter) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tsVC setScreen];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.tsVC.view];
}
-(void)closeTipSetter
{
    
    [self.tsVC.view removeFromSuperview];
}
@end
