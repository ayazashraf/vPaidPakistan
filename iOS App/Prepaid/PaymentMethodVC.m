//
//  PaymentMethodVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 25/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "PaymentMethodVC.h"
#import "PaymentMethodCell.h"

#import <QuartzCore/CALayer.h>
#import <QuartzCore/QuartzCore.h>
@interface PaymentMethodVC ()
{
    NSMutableArray * paymentmethodsAvailabe;
}

@end

@implementation PaymentMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self.paymentMethodTableView reloadData];
    // Do any additional setup after loading the view.
}
-(void)initData
{
    paymentmethodsAvailabe = [[NSMutableArray alloc] init];
    NSMutableDictionary * temp_dic = [[NSMutableDictionary alloc] init];
    [temp_dic setObject:@"notes" forKey:@"paymentImage"];
    [temp_dic setObject:@"Cash" forKey:@"paymentName"];
    [temp_dic setObject:@"Cash on delivery" forKey:@"paymentSubTitle"];
    
    [paymentmethodsAvailabe addObject:temp_dic];
    
//    NSMutableDictionary * visa_dic = [[NSMutableDictionary alloc] init];
//    [visa_dic setObject:@"card_visa" forKey:@"paymentImage"];
//    [visa_dic setObject:@"Visa" forKey:@"paymentName"];
//    [visa_dic setObject:@"**** **** **** 1234" forKey:@"paymentSubTitle"];
//    
//    [paymentmethodsAvailabe addObject:visa_dic];
//    
//    NSMutableDictionary * master_dic = [[NSMutableDictionary alloc] init];
//    [master_dic setObject:@"master_card" forKey:@"paymentImage"];
//    [master_dic setObject:@"Master" forKey:@"paymentName"];
//    [master_dic setObject:@"**** **** **** 5678" forKey:@"paymentSubTitle"];
//    
//    [paymentmethodsAvailabe addObject:master_dic];
    
    NSMutableDictionary * paypal_dic = [[NSMutableDictionary alloc] init];
    [paypal_dic setObject:@"paypal" forKey:@"paymentImage"];
    [paypal_dic setObject:@"PayPal" forKey:@"paymentName"];
    [paypal_dic setObject:@"abc_def@example.com" forKey:@"paymentSubTitle"];
    [paymentmethodsAvailabe addObject:paypal_dic];
    
    NSMutableDictionary * stripe_dic = [[NSMutableDictionary alloc] init];
    [stripe_dic setObject:@"stripe" forKey:@"paymentImage"];
    [stripe_dic setObject:@"Stripe" forKey:@"paymentName"];
    [stripe_dic setObject:@"abc_def@example.com" forKey:@"paymentSubTitle"];
    
    [paymentmethodsAvailabe addObject:stripe_dic];
}
#pragma mark - UITABLEVIEW DATASOURVE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return paymentmethodsAvailabe.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PaymentMethodCell";
    
    PaymentMethodCell *cell = (PaymentMethodCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.paymentImage.image = [UIImage imageNamed:[[paymentmethodsAvailabe objectAtIndex:indexPath.row] valueForKey:@"paymentImage"]];
    cell.paymentName.text = [[paymentmethodsAvailabe objectAtIndex:indexPath.row] valueForKey:@"paymentName"];
    cell.paymentSubTitle.text = [[paymentmethodsAvailabe objectAtIndex:indexPath.row] valueForKey:@"paymentSubTitle"];
    CALayer *cellImageLayer = cell.contentViewOfCell.layer;
    [cellImageLayer setCornerRadius:5];
    [cellImageLayer setMasksToBounds:YES];
    return cell;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
