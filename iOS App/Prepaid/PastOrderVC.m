//
//  PastOrderVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 06/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "PastOrderVC.h"
#import "PastOrdersCell.h"
#import "SWRevealViewController.h"
#import "PastOrderCell.h"
#import "TrackOrderDetailVC.h"
@interface PastOrderVC ()

@end

@implementation PastOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];

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

#pragma mark - UITABLEVIEW DATASOURVE
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 119;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PastOrderCell";
    
    PastOrderCell *cell = (PastOrderCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastOrderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        //6EF0DC
    }
    cell.ResturantName.text = @"Burger King";
    cell.amountLabel.text = @"Rs 1,500";
    cell.dateLabel.text = @"March 17, 2017 3:30 PM";
    cell.ResturantLogo.image = [UIImage imageNamed:@"burgerKing"];
    cell.ratingView.userInteractionEnabled = NO;
    cell.ratingView.maxRating = 5;
    cell.ratingView.canEdit = NO;
    cell.ratingView.rating = 0;
    return cell;
}

#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TrackOrderDetailVC * todVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TrackOrderDetailVC"];
    [self.navigationController pushViewController:todVC animated:YES];
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
