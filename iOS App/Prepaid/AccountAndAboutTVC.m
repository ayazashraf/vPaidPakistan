//
//  AccountAndAboutTVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 14/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "AccountAndAboutTVC.h"
#import "ContactUsVC.h"
#import "NumberChangeVC.h"
@interface AccountAndAboutTVC ()
{
    NSMutableArray *arr;
}

@end

@implementation AccountAndAboutTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if([self.tableViewCode isEqualToString:@"0"])
    {
        arr = [[NSMutableArray alloc] init];
        [arr addObject:@"Change your phone number"];
    }
    else if([self.tableViewCode isEqualToString:@"1"])
    {
        arr = [[NSMutableArray alloc] init];
        [arr addObject:@"About"];
        [arr addObject:@"Contact Us"];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountAndAboutCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.tableViewCode isEqualToString:@"1"] && indexPath.row == 1)
    {
        ContactUsVC * cuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsVC"];
        
        [self.navigationController pushViewController:cuVC animated:YES];
    }
//
    else if([self.tableViewCode isEqualToString:@"0"] && indexPath.row == 0)
    {
        NumberChangeVC * ncVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NumberChangeVC"];
        [self.navigationController pushViewController:ncVC animated:YES];
    }
}
@end
