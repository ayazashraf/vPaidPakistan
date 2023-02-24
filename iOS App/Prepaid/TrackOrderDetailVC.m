//
//  TrackOrderDetailVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 19/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "TrackOrderDetailVC.h"
#import "OrderSummaryCell.h"
#import "OrderBillingDetailsCell.h"
#import <CoreData/CoreData.h>
@interface TrackOrderDetailVC ()
{
    NSMutableArray * order_summary;
}

@end

@implementation TrackOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.trackOrderDetailTableView.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segmentValueChanged:(id)sender {
    UISegmentedControl * segment  = (UISegmentedControl*)sender;
    if(segment.selectedSegmentIndex == 0)
    {
        self.trackOrderBillingTableView.hidden = NO;
        
        [self.trackOrderBillingTableView reloadData];
        self.trackOrderDetailTableView.hidden = YES;
        
    }
    else
    {
        
        self.trackOrderBillingTableView.hidden = YES;
        
        [self.trackOrderDetailTableView reloadData];
        self.trackOrderDetailTableView.hidden = NO;
    }
}
-(void)initData
{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Current_item_cart"];
    order_summary = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.trackOrderBillingTableView reloadData];
    [self CalculateTotalBill];
}
-(void)CalculateTotalBill
{
    float total_bill = 0.0;
    for(int i = 0; i < order_summary.count; i++)
    {
        NSManagedObject *order_items = [order_summary objectAtIndex:i];
        total_bill = total_bill +  [[order_items valueForKey:@"item_price_total"] doubleValue];
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 20;
    
    self.totalBil.text = [NSString stringWithFormat:@"Rs %@", [formatter stringFromNumber:[NSNumber numberWithFloat:total_bill]]];
}

#pragma mark - UITABLEVIEW DATASOURVE
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 4;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *simpleTableIdentifier = @"MainHomeTableViewCell";
    if(tableView == self.trackOrderBillingTableView)
    {
        if(indexPath.section == 0)
        {
            OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"PastOrderDetailCell"];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastOrderDetailCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            
            NSManagedObject *order_items = [order_summary objectAtIndex:indexPath.row];
            cell.orderItemName.text = [order_items valueForKey:@"item_name"];
            cell.orderQuantityLabel.text = [order_items valueForKey:@"item_quantity"];
            
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            formatter.maximumFractionDigits = 20;
            
            cell.orderAmount.text  = [NSString stringWithFormat:@"Rs %@", [formatter stringFromNumber:[NSNumber numberWithFloat:[[order_items valueForKey:@"item_price_total"] doubleValue]]]];
            
            
            cell.orderMinusBtn.hidden = YES;
            cell.orderPlusBtn.hidden = YES;
            return cell;
        }
        else if(indexPath.section == 1)
        {
            OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"PastOrderDetailCell"];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastOrderDetailCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.orderItemName.text = @"Sales Tax";
            cell.orderQuantityLabel.hidden = YES;
            cell.orderAmount.text = @"Rs. 250";
            cell.orderMinusBtn.hidden = YES;
            cell.orderPlusBtn.hidden = YES;
            return cell;
        }
        else
        {
            OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"PastOrderDetailCell"];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastOrderDetailCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.orderItemName.text = @"Tip";
            cell.orderQuantityLabel.hidden = YES;
            cell.orderAmount.text = @"Rs. 50";
            cell.orderMinusBtn.hidden = YES;
            cell.orderPlusBtn.hidden = YES;
            
            return cell;
        }
    }
    else
    {
//        OrderBillingDetailsCell
        OrderBillingDetailsCell *cell = (OrderBillingDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderTrackDetailCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderTrackDetailCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.trackOrderBillingTableView)
    {
        if(section == 0)
            return @"Items";
        else if(section == 1)
            return @"Sales Tax";
        else
            return @"Tip";
    }
    else
        return @"";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(tableView == self.trackOrderBillingTableView)
        return 3;
    else
        return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(tableView == self.trackOrderBillingTableView)
    {
        if(section == 0)
            return order_summary.count;
        else if(section == 1)
            return 1;
        else
            return 1;
    }
    else
        return 12;
}
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - CORE DATA METHODS
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
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
