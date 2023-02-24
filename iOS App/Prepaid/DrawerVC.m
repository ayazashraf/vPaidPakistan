//
//  DrawerVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 22/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "DrawerVC.h"
#import <QuartzCore/CALayer.h>
#import "UIImageView+Letters.h"
@interface DrawerVC ()
{
    NSArray *menuItems;
}

@end

@implementation DrawerVC

- (void)viewDidLoad {
    [super viewDidLoad];
     menuItems = @[@"home", @"profile", @"pastOrder", @"trackOrder", @"about"];
    NSString *userName = @"Ahmed Shahid";
    [self.accountImage setImageWithString:userName color:nil circular:YES];
    CALayer *accImgLayer = self.accountImage.layer;
    [accImgLayer setCornerRadius:accImgLayer.frame.size.height/2];
    [accImgLayer setMasksToBounds:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
