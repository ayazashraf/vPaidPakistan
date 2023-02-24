//
//  OrderSummaryVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 18/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "OrderSummaryVC.h"
#import "OrderSummaryCell.h"
#import "SWRevealViewController.h"
#import <CoreData/CoreData.h>
@interface OrderSummaryVC ()
{
    NSMutableArray * order_summary;
}

@end

@implementation OrderSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.continueBtn.layer.cornerRadius = 5;
    
     SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueBtnPress:(id)sender {
    
}


-(void)initData
{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Current_item_cart"];
    order_summary = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.orderSummarytableView reloadData];
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
   
    self.totalBillLabel.text = [NSString stringWithFormat:@"$ %@", [formatter stringFromNumber:[NSNumber numberWithFloat:total_bill]]];
}
#pragma mark - UITABLEVIEW DATASOURVE
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 4;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            //static NSString *simpleTableIdentifier = @"MainHomeTableViewCell";
    if(indexPath.section == 0)
    {
        OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderSummaryCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderSummaryCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        NSManagedObject *order_items = [order_summary objectAtIndex:indexPath.row];
        cell.orderItemName.text = [order_items valueForKey:@"item_name"];
        cell.orderQuantityLabel.text = [order_items valueForKey:@"item_quantity"];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        formatter.maximumFractionDigits = 20;
        
        cell.orderAmount.text  = [NSString stringWithFormat:@"$ %@", [formatter stringFromNumber:[NSNumber numberWithFloat:[[order_items valueForKey:@"item_price_total"] doubleValue]]]];
        
        
        cell.orderPlusBtn.tag=indexPath.row;
        [cell.orderPlusBtn addTarget:self action:@selector(orderPlusBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.
        orderMinusBtn.tag=indexPath.row;
        [cell.orderMinusBtn addTarget:self action:@selector(orderMinusBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderSummaryCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderSummaryCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.orderItemName.text = @"Sales Tax";
        cell.orderQuantityLabel.hidden = YES;
        cell.orderAmount.text = @"$ 15";
        cell.orderMinusBtn.hidden = YES;
        cell.orderPlusBtn.hidden = YES;
        return cell;
    }
    else
    {
        OrderSummaryCell *cell = (OrderSummaryCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderSummaryCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderSummaryCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.orderItemName.text = @"Service Charges";
        cell.orderQuantityLabel.hidden = YES;
        cell.orderAmount.text = @"$ 5";
        cell.orderMinusBtn.hidden = YES;
        cell.orderPlusBtn.hidden = YES;

        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Items";
    else if(section == 1)
        return @"Sales Tax";
    else
        return @"Extra Charges";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
        return order_summary.count;
    else if(section == 1)
        return 1;
    else
        return 1;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[order_summary objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [order_summary removeObjectAtIndex:indexPath.row];
        [self.orderSummarytableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self CalculateTotalBill];
    }
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
//    v.backgroundView.backgroundColor = [self colorWithHexString:@"AAAAAA"];
//}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)orderMinusBtn:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger buttonTagIndex = btn.tag;

    NSManagedObject *order_items = [order_summary objectAtIndex:buttonTagIndex];
    int item = [[order_items valueForKey:@"item_quantity"] intValue];
    if(item > 1)
    {
        item--;
        double price =[[order_items valueForKey:@"item_price"] doubleValue];
        price = item * price;
        
        [order_items setValue:[NSString stringWithFormat:@"%d", item] forKey:@"item_quantity"];
        [order_items setValue:[NSString stringWithFormat:@"%f", price] forKey:@"item_price_total"];
        [self initData];
    }
}

-(void)orderPlusBtn:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger buttonTagIndex = btn.tag;
    NSManagedObject *order_items = [order_summary objectAtIndex:buttonTagIndex];
    int item = [[order_items valueForKey:@"item_quantity"] intValue];
    item++;
    double price =[[order_items valueForKey:@"item_price"] doubleValue];
    price = item * price;
    [order_items setValue:[NSString stringWithFormat:@"%d", item] forKey:@"item_quantity"];
    [order_items setValue:[NSString stringWithFormat:@"%f", price] forKey:@"item_price_total"];
    [self initData];
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
