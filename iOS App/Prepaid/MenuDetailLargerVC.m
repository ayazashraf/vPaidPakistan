//
//  MenuDetailLargerVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 21/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "MenuDetailLargerVC.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/CALayer.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "iToast.h"
@interface MenuDetailLargerVC ()

@end

@implementation MenuDetailLargerVC
@synthesize fg_price,
fg_image,
fg_cart_btn,
fg_description,
fg_name;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@synthesize bg;
-(void) setScreen
{
    [self.backgroundView setFrame:self.view.frame];
    [bg setFrame:self.view.frame];
    [self.closeBtn setFrame:self.view.frame];
    UIImage *image = [UIImage convertViewToImage];
    UIImage *blurSnapshotImage = nil;
    blurSnapshotImage = [image applyBlurWithRadius:5.0
                                         tintColor:[UIColor colorWithWhite:0.2
                                                                     alpha:0.7]
                             saturationDeltaFactor:1.8
                                         maskImage:nil];
    
    bg.image = blurSnapshotImage;
    bg.alpha = 1.0;
    [self PlaceForegroundViewDynamically];
    [self PlaceForegroundImageNameAndPriceDynamically];
    [self PlaceForegroundTextViewDynamically];
    [self PlaceForegroundLastBtnDynamically];
    [self AdjustForegroundViewHeight];

}
-(void)PlaceForegroundImageNameAndPriceDynamically
{
    [fg_image setFrame:CGRectMake(8, 8, 75, 75)];
    
    CGFloat both_x = fg_image.frame.origin.x + fg_image.frame.size.width + 14; // 14 is buffer
    CGFloat name_y = 8;

    
    CGFloat both_width = self.foregroundView.frame.size.width - both_x - 8; //8 is trailing buffer from fg view
    CGFloat both_height = 34; // constant Height
    
    CGFloat price_y = name_y + both_height + 8;
    
    [fg_name setFrame:CGRectMake(both_x, name_y, both_width, both_height)];
    [fg_price setFrame:CGRectMake(both_x, price_y, both_width, both_height)];
    
    
}
-(void)PlaceForegroundViewDynamically
{
    CGFloat width = self.view.frame.size.width - (self.view.frame.size.width / 4);
    CGFloat height = (self.view.frame.size.height / 32) * 13;
    CGFloat x = (self.view.frame.size.width / 2) - (width / 2);
    CGFloat y = (self.view.frame.size.height / 2) - (height / 2);
    
    CGRect fgRect = CGRectMake(x, y, width, height);
    [self.foregroundView setFrame:fgRect];
    
    self.foregroundView.layer.cornerRadius = 10;
    self.foregroundView.layer.borderWidth = 2;
    self.foregroundView.layer.borderColor = [UIColor blackColor].CGColor;
}

-(void)PlaceForegroundTextViewDynamically
{
    CGFloat x = 8;
    CGFloat y  = fg_image.frame.origin.x + fg_image.frame.size.height + 8; // 8 for buffer
    
    CGFloat width = self.foregroundView.frame.size.width - 16; // 8 + 8 buffer for leading and trailing
    CGFloat height = fg_description.contentSize.height;
    NSLog(@"textview height: %f", height);
    [fg_description setFrame:CGRectMake(x, y, width, height)];
}

-(void)PlaceForegroundLastBtnDynamically
{
    CGFloat x = (self.foregroundView.frame.size.width / 2) - 15;
    CGFloat y = fg_description.frame.origin.y + fg_description.frame.size.height;
    
    CGFloat width = 30;
    CGFloat height = 30;
    
    [fg_cart_btn setFrame:CGRectMake(x, y, width, height)];
}

-(void)AdjustForegroundViewHeight
{
    if(!(self.foregroundView.frame.size.height <= (fg_image.frame.size.height + fg_description.frame.size.height + fg_cart_btn.frame.size.height + 32)/*(fg_description.frame.size.height + fg_cart_btn.frame.size.height + 16)*/))
    {
        [self.foregroundView setFrame:CGRectMake(self.foregroundView.frame.origin.x, self.foregroundView.frame.origin.y, self.foregroundView.frame.size.width, (fg_image.frame.size.height + fg_description.frame.size.height + fg_cart_btn.frame.size.height + 32))];
    }
    else
    {
        CGFloat newHeight = self.foregroundView.frame.size.height - fg_description.frame.origin.y - 38;
        [fg_description setFrame:CGRectMake(fg_description.frame.origin.x, fg_description.frame.origin.y, fg_description.frame.size.width,  newHeight)];
        
        [self PlaceForegroundLastBtnDynamically];
    }
}
- (IBAction)closeBtnTouch:(id)sender {
    
}
- (IBAction)addToCartBtn:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"item_id == %@", [self.item_dic valueForKey:@"item_id"]];
    [request setEntity:[NSEntityDescription entityForName:@"Current_item_cart" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(results.count > 0)
    {
        NSManagedObject *order_items = [results firstObject];
        int num_of_item = [[order_items valueForKey:@"item_quantity"] intValue];
        num_of_item++;
        double price =[[order_items valueForKey:@"item_price"] doubleValue];
        price = num_of_item * price;
        [order_items setValue:[NSString stringWithFormat:@"%d", num_of_item] forKey:@"item_quantity"];
        [order_items setValue:[NSString stringWithFormat:@"%f", price] forKey:@"item_price_total"];
        
        [[[[iToast makeText:[NSString stringWithFormat:@"%@ has added into your cart.",[self.item_dic valueForKey:@"item_name"]]]
           setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
    }
    else
    {
        //Create a new managed object
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Current_item_cart" inManagedObjectContext:context];
        [newDevice setValue:[self.item_dic valueForKey:@"item_name"] forKey:@"item_name"];
        [newDevice setValue:[self.item_dic valueForKey:@"item_price"] forKey:@"item_price"];
        [newDevice setValue:[self.item_dic valueForKey:@"item_price"] forKey:@"item_price_total"];
        [newDevice setValue:[self.item_dic valueForKey:@"item_id"] forKey:@"item_id"];
        [newDevice setValue:@"1" forKey:@"item_quantity"];
        
        /*NSError */error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else  
        {
            [[[[iToast makeText:[NSString stringWithFormat:@"%@ has added into your cart.",[self.item_dic valueForKey:@"item_name"]]]
               setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
        }
    }
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
