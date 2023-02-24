//
//  TrackOrderVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 24/03/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "TrackOrderVC.h"
#import "SWRevealViewController.h"
#import "MyAnnotation.h"
#import "WebRequest.h"
#import "JPSThumbnailAnnotation.h"
#import "Constants.h"
#import "OrderSummaryCell.h"
#import "OrderBillingDetailsCell.h"
#import <CoreData/CoreData.h>
@interface TrackOrderVC ()
{
    NSArray *menuItems;
    BOOL CallOnlyOnce;
    NSMutableArray * order_summary;
}
@property (nonatomic,strong)MyAnnotation *sourceAnnotation;
@property (nonatomic,strong)MyAnnotation *destinationAnnotation;
@property (nonatomic,strong) NSMutableArray * item_details;
@property (nonatomic,strong) MKPolyline *polyLine;
@property (nonatomic,strong)CLGeocoder *geocoder;


@property  (nonatomic,strong) CLLocationManager *LocationManager;
@end

@implementation TrackOrderVC
@synthesize destinationAnnotation, Destination, Source, LocationManager, sourceAnnotation, polyLine, geocoder;
- (void)viewDidLoad {
    [super viewDidLoad];
    _item_details = [[NSMutableArray alloc] init];
    CallOnlyOnce = NO;
    //[self GetMyPositionClicked];
    menuItems = @[@"confirm", @"preparing", @"served", @"finsh"];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.drawerBtn setTarget: self.revealViewController];
        [self.drawerBtn setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [_mapView setDelegate:self];
    [self GetMyPositionClicked];
    [self initData];
}

-(void)initData
{
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Current_item_cart"];
    order_summary = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //
    [self.billTableView reloadData];
    [self CalculateTotalBill];
    
    _item_details = [[NSMutableArray alloc] init];
    // for(int i = 0; i < 2; i++)
    // {
    NSMutableDictionary * dicTemp1 = [[NSMutableDictionary alloc] init];
    [dicTemp1 setValue:@"Brekkie Crunch Wrap" forKey:@"item_name"];
    [dicTemp1 setValue:@"Beef cooked in a pastry crunch" forKey:@"item_detail"];
    [dicTemp1 setValue:@"240" forKey:@"item_price"];
    [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
    [dicTemp1 setValue:@"01" forKey:@"item_id"];
    [dicTemp1 setValue:@"3" forKey:@"item_qty"];
    
    [_item_details addObject:dicTemp1];
    
    NSMutableDictionary * dicTemp2 = [[NSMutableDictionary alloc] init];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_name"];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_detail"];
    [dicTemp2 setValue:@"150" forKey:@"item_price"];
    [dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
    [dicTemp2 setValue:@"02" forKey:@"item_id"];
        [dicTemp2 setValue:@"3" forKey:@"item_qty"];
    [_item_details addObject:dicTemp2];
    
    NSMutableDictionary * dicTemp3 = [[NSMutableDictionary alloc] init];
    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos" forKey:@"item_name"];
    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
    [dicTemp3 setValue:@"150" forKey:@"item_price"];
    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
    [dicTemp3 setValue:@"03" forKey:@"item_id"];
        [dicTemp3 setValue:@"3" forKey:@"item_qty"];
    [_item_details addObject:dicTemp3];
    
    dicTemp1 = [[NSMutableDictionary alloc] init];
    [dicTemp1 setValue:@"Brekkie Crunch Wrap 2" forKey:@"item_name"];
    [dicTemp1 setValue:@"Beef cooked in a pastry crunch" forKey:@"item_detail"];
    [dicTemp1 setValue:@"240" forKey:@"item_price"];
    [dicTemp1 setValue:@"kfc_menu_01" forKey:@"item_image"];
    [dicTemp1 setValue:@"04" forKey:@"item_id"];
        [dicTemp1 setValue:@"3" forKey:@"item_qty"];
    [_item_details addObject:dicTemp1];
    
    dicTemp2 = [[NSMutableDictionary alloc] init];
    [dicTemp2 setValue:@"Chilli Twist 2" forKey:@"item_name"];
    [dicTemp2 setValue:@"Chilli Twist" forKey:@"item_detail"];
    [dicTemp2 setValue:@"150" forKey:@"item_price"];
    [dicTemp2 setValue:@"kfc_menu_02" forKey:@"item_image"];
    [dicTemp2 setValue:@"05" forKey:@"item_id"];
        [dicTemp2 setValue:@"3" forKey:@"item_qty"];
    [_item_details addObject:dicTemp2];
    
    dicTemp3 = [[NSMutableDictionary alloc] init];
    [dicTemp3 setValue:@"Toaist: Cheese & Tomatos 2" forKey:@"item_name"];
    [dicTemp3 setValue:@"Egg, cheese, tomato & sauces covered in a slices" forKey:@"item_detail"];
    [dicTemp3 setValue:@"150" forKey:@"item_price"];
    [dicTemp3 setValue:@"kfc_menu_03" forKey:@"item_image"];
    [dicTemp3 setValue:@"06" forKey:@"item_id"];
        [dicTemp3 setValue:@"3" forKey:@"item_qty"];
    [_item_details addObject:dicTemp3];
    
    [self.orderDetailsTableView reloadData];
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
    
    self.totalBillLabel.text = [NSString stringWithFormat:@"Rs %@", [formatter stringFromNumber:[NSNumber numberWithFloat:total_bill]]];
}
-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    //    [self.LocationManager stopUpdatingLocation];
    //    self.LocationManager = nil;
}
- (NSArray *)annotations {
    // Empire State Building
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"kfcLogo1"];
    empire.title = @"KFC";
    empire.subtitle = @"KFC karachi";
    //empire.coordinate = CLLocationCoordinate2DMake(40.75f,-73.99f);
    empire.coordinate = CLLocationCoordinate2DMake(Destination.latitude,Destination.longitude);
    empire.disclosureBlock = ^{
        
    };
    
    // Apple HQ
    JPSThumbnail *apple = [[JPSThumbnail alloc] init];
    apple.image = [UIImage imageNamed:@"profile"];
    apple.title = @"Your location";
    apple.subtitle = @"your location";
    apple.coordinate = CLLocationCoordinate2DMake(Source.latitude, Source.longitude);
    apple.disclosureBlock = ^{};
    
    //    // Parliament of Canada
    //    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    //    ottawa.image =nil;
    //    ottawa.title = @"Parliament of Canada";
    //    ottawa.subtitle = @"Oh Canada!";
    //    ottawa.coordinate = CLLocationCoordinate2DMake(45.43f, -75.70f);
    //    ottawa.disclosureBlock = ^{};
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:empire],
             [JPSThumbnailAnnotation annotationWithThumbnail:apple],
             /*[JPSThumbnailAnnotation annotationWithThumbnail:ottawa]*/];
    
    
}

- (void)GetMyPositionClicked
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}
-(MyAnnotation *)focusmapWithLat:(double)lat Long:(double)log
{
    
    MyAnnotation *annot=[MyAnnotation alloc];
    
    CLLocationCoordinate2D cordloc;
    
    cordloc.latitude=lat ;
    cordloc.longitude=log;
    
    [annot setCoordinate:cordloc];
    annot.title = @"location 1";//BusinessTitle;
    [_mapView addAnnotation:annot];
    
    
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 1.0;
    span.longitudeDelta = 1.0;
    
    region.span = span;
    region.center = cordloc;
    [_mapView setRegion:region animated:YES];
    
    return annot;
    
    
}
-(MyAnnotation *)focusmaponPinWithLat:(double)lat Long:(double)log Title:(NSString *)title AndFocus:(BOOL)focus
{
    
    MyAnnotation  *anot=[MyAnnotation alloc];
    
    CLLocationCoordinate2D cordloc;
    
    cordloc.latitude=lat ;
    cordloc.longitude=log;
    
    [anot setCoordinate:cordloc];
    anot.title=title;
    [_mapView addAnnotation:anot];
    
    
    if(focus)
    {
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 1.0;
        span.longitudeDelta = 1.0;
        
        region.span = span;
        region.center = cordloc;
        [_mapView setRegion:region animated:YES];
        
    }
    
    return anot;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(tableView == self.trackOrderTableView)
        return 1;
    else
        return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.billTableView)
    {
        if(section == 0)
            return order_summary.count;
        else if(section == 1)
            return 1;
        else
            return 1;
    }
    else if(tableView == self.orderDetailsTableView)
        return _item_details.count;
    else
        return menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.trackOrderTableView)
    {
        NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if(tableView == self.billTableView)
    {
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
            
            cell.orderAmount.text  = [NSString stringWithFormat:@"Rs %@", [formatter stringFromNumber:[NSNumber numberWithFloat:[[order_items valueForKey:@"item_price_total"] doubleValue]]]];
            
            
            cell.orderPlusBtn.tag=indexPath.row;
            cell.orderPlusBtn.hidden = YES;
           // [cell.orderPlusBtn addTarget:self action:@selector(orderPlusBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.orderMinusBtn.tag=indexPath.row;
            cell.orderMinusBtn.hidden = YES;
           // [cell.orderMinusBtn addTarget:self action:@selector(orderMinusBtn:) forControlEvents:UIControlEventTouchUpInside];
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
            cell.orderAmount.text = @"Rs. 250";
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
            cell.orderItemName.text = @"Tip";
            cell.orderQuantityLabel.hidden = YES;
            cell.orderAmount.text = @"Rs. 50";
            cell.orderMinusBtn.hidden = YES;
            cell.orderPlusBtn.hidden = YES;
            
            return cell;
        }

    }
    else if(tableView == self.orderDetailsTableView)
    {
        OrderBillingDetailsCell *cell = (OrderBillingDetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"OrderBillingDetailsCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderBillingDetailsCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.billingDetailsItemLabel.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_name"];
        cell.billingDetailsItemRecipe.text = [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_detail"];
        cell.billingDetailsItemImage.image = [UIImage imageNamed:[[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_image"]];
        cell.billingDetailsItemAmount.text =[NSString stringWithFormat:@"Rs %@", [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_price"]];
        cell.billingDetailsItemQty.text =[NSString stringWithFormat:@"Qty: %@", [[self.item_details objectAtIndex:indexPath.row] valueForKey:@"item_qty"]];
        return cell;
    }
    else
        return nil;
}
#pragma mark -UITABLEVIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.billTableView)
    {
    if(section == 0)
        return @"Items";
    else if(section == 1)
        return @"Sales Tax";
    else
        return @"Tip";
    }
    else
        return nil;
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if(section == 0)
//        return order_summary.count;
//    else if(section == 1)
//        return 1;
//    else
//        return 1;
//}
#pragma mark - Location Manager Delegate
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    if(sourceAnnotation)
//        [_mapView removeAnnotation:sourceAnnotation];
//    if(polyLine)
//        [_mapView removeOverlay:polyLine];
//    
//    [manager stopUpdatingLocation];
//    
//    CLLocation *loc = [locations lastObject];
//    Source = loc.coordinate;
//    geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarker, NSError *error){
//        
//        CLPlacemark *placeMark=[[CLPlacemark alloc]initWithPlacemark:[placemarker objectAtIndex:0]];
//        NSString* loc_name=[NSString stringWithFormat:@"%@",placeMark.name];
//        
//        [self focusmaponPinWithLat:loc.coordinate.latitude Long:loc.coordinate.longitude Title:loc_name AndFocus:YES];
//        
//    }];
//    
//    
//    
//}
//
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    [manager stopUpdatingLocation];
//}
//


- (void)GetRouteClicked {
    
    if(polyLine)
        [_mapView removeOverlay:polyLine];
    
    NSString  *Api =[NSString stringWithFormat:@"%@origin=%f,%f&destination=%f,%f&sensor=true&mode=driving&alternatives=false",GOOGLE_TRACK_LOCATION_BASE_URL, user_current_location_lat,user_current_location_lng, Destination.latitude,Destination.longitude];
    
    NSLog(@"google: %@", Api);
    
    // Api = [Api stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Api= [Api stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [WebRequest AsyncRequestForData:Api onCompletion:^(NSData *data, NSError *error){
        
        NSError *errorj= nil;
        if(!error)
        {
            NSDictionary *response=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorj ];
            
            if(!errorj && [[response objectForKey:@"status"] isEqualToString:@"OK"])
            {
                NSArray *routes = [response objectForKey:@"routes"];
                NSDictionary *route = [routes lastObject];
                NSDictionary *legs=[route objectForKey:@"legs"];
                NSArray *steps=[legs valueForKey:@"steps"];
                NSArray *allhtmlstrings=[steps valueForKey:@"html_instructions"];
                NSString *overviewPolyline = [[route objectForKey: @"overview_polyline"] objectForKey:@"points"];
                
                NSMutableString *encode=[[NSMutableString alloc]initWithString:overviewPolyline];
                NSMutableArray *pointarray=[[NSMutableArray alloc]init];
                pointarray=[self decodePolyLine:encode];
                
                //NSLog(@"%@",[pointarray description]);
                NSInteger numberOfSteps = pointarray.count;
                
                
                if (numberOfSteps>0) {
                    
                    CLLocationCoordinate2D coordinates[numberOfSteps];
                    for (NSInteger index = 0; index < numberOfSteps; index++) {
                        CLLocation *location = [pointarray objectAtIndex:index];
                        CLLocationCoordinate2D coordinate = location.coordinate;
                        
                        coordinates[index] = coordinate;
                    }
                    polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [_mapView addOverlay:polyLine];
                        [_mapView setNeedsDisplay];
                        // [self addroutesDetailviewwithArray:allhtmlstrings];
                        
                        
                    });
                    
                    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(Destination, 2500, 2500);
                    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
                    
                }
                else
                {
                    
                }
                
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // [iToast showErrorToast:@"no route exist between source and destination." title:@"error"];
                    
                });
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //[LoadingOverlay removeLoadingFromView:self.view];
            
        });
        
    }];
}

#pragma mark MKPolyline delegate functions
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [UIColor blackColor];
    polylineView.lineWidth = 10.0;
    return polylineView;
}
- (NSMutableArray *)decodePolyLine: (NSMutableString *)encoded
{
    @try {
        
        
        [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\" options:NSLiteralSearch range:NSMakeRange(0, [encoded length])];
        NSInteger len = [encoded length];
        NSInteger index = 0;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSInteger lat=0;
        NSInteger lng=0;
        while (index < len)
        {
            NSInteger b;
            NSInteger shift = 0;
            NSInteger result = 0;
            do
            {
                b = [encoded characterAtIndex:index++] - 63;
                result |= (b & 0x1f) << shift;
                shift += 5;
            } while (b >= 0x20);
            NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
            lat += dlat;
            shift = 0;
            result = 0;
            do
            {
                b = [encoded characterAtIndex:index++] - 63;
                result |= (b & 0x1f) << shift;
                shift += 5;
            } while (b >= 0x20);
            NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
            lng += dlng;
            NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
            NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
            //printf("[%f,", [latitude doubleValue]);
            //printf("%f]", [longitude doubleValue]);
            CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
            [array addObject:loc];
        }
        
        return array;
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    
    
}






#pragma mark - Location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    user_current_location_lat = newLocation.coordinate.latitude;
    user_current_location_lng = newLocation.coordinate.longitude;
    
    if(!CallOnlyOnce)
    {
        [self PlaceThingsOnMap];
    }
}
-(void)PlaceThingsOnMap
{
    CallOnlyOnce = YES;
    Destination.latitude = 24.882672;
    Destination.longitude = 67.067472;
    
    Source.latitude = user_current_location_lat;
    Source.longitude = user_current_location_lng;
    // destinationAnnotation = [self focusmapWithLat:Destination.latitude Long:Destination.longitude];
    // sourceAnnotation = [self focusmapWithLat:Source.latitude Long:Source.longitude];
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        [_mapView addAnnotations:[self annotations]];
    });
    
    [self GetRouteClicked];
    // Do any additional setup after loading the view.

}


//- (void) makeRequest
//{
//
//    //NSString *string1 = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=Karachi,pk&appid=2219c477d9e3c940078ecc0e68f9a99b&units=metric"];
//    // NSString *string2 = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
//    NSString *string = [NSString stringWithFormat:@"https://api.meetup.com/2/groups?&sign=true&lat=24.8615&lon=67.0099&page=20&key=481f2f1a28363475584806f6e6c1524"];
//    NSURL *url = [NSURL URLWithString:string];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//
//    [manager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *data = (NSDictionary*)responseObject;
//            NSString *checkError = [data valueForKey:@"error"];
//            if([checkError integerValue] == 0){
//                NSDictionary *responseData = [data valueForKey:@"results"];
//
//                for(NSDictionary *cityDescription in responseData)
//                {
//                    //                    NSLog(@"City name and description is %@",cityDescription);
//
//                    NSDictionary *city = [cityDescription objectForKey:@"city"];
//                    //                 NSLog(@"video data message %@",imageURL);
//                    NSDictionary *name = [cityDescription objectForKey:@"name"];
//
//                    NSDictionary *country = [cityDescription objectForKey:@"country"];
//                    //                 NSLog(@"title data message %@",titleMessage);
//                    NSDictionary *descriptionMessage = [cityDescription objectForKey:@"description"];
//
//                    [tablewViewArrayForName addObject:name];
//                    [tablewViewArrayForCity addObject:city];
//                    [tablewViewArrayForCountry addObject:country];
//                    [tablewViewArrayForDescription addObject:descriptionMessage];
//
//                    //                    [meetVC.cityGeneralInfoInArrayForDescription addObject:name];
//
//                }
//                [self.TableView reloadData];
//
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//            }
//            else{
//                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"internal server error..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alert show];
//            }
//
//
//        }else if ([responseObject isKindOfClass:[NSArray class]]){
//            //This is an NSArray, you cannot call 'valueForKey' on this responseObject
//        }
//
//
//
//    }
//         failure:^(NSURLSessionTask *operation, NSError *error) {
//             [MBProgressHUD hideHUDForView:self.view animated:YES];
//             NSLog(@"Error: %@", error);
//             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"no internet connection.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//             [alert show];
//         }];
//
//}
//
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
//-(void)addroutesDetailviewwithArray:(NSArray*)htmlArray
//{
//
//    NSArray *htmlstringArray=[htmlArray lastObject];
//    if(routesDetailView)
//        [ routesDetailView removeFromSuperview];
//    routesDetailView=[[UIView alloc]initWithFrame:(CGRect){RouteControlsView.frame.origin.x,RouteControlsView.frame.origin.y+RouteControlsView.frame.size.height+10,RouteControlsView.frame.size.width,400}];
//    [routesDetailView.layer setMasksToBounds:YES];
//    [routesDetailView.layer setCornerRadius:5.0];
//    [routesDetailView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
//    [routesDetailView.layer setBorderWidth:1.0f];
//    [routesDetailView setBackgroundColor:[UIColor clearColor ]  ];
//    UIWebView *htmlTextview=[[UIWebView alloc]initWithFrame:CGRectMake(5, 5, routesDetailView.frame.size.width-10, routesDetailView.frame.size.height-10)];
//    NSString *htmlDirections=@"";
//    for (int i=0; i<[htmlstringArray count]; i++) {
//        htmlDirections=[htmlDirections stringByAppendingString:[NSString stringWithFormat:@"<br>%@",[htmlstringArray objectAtIndex:i]]];
//    }
//    UIFont *font=[UIFont systemFontOfSize:21];
//    htmlDirectionString=[NSString stringWithFormat:@"<body style=\"background-color:#4d4d4d;color:white; font-family:helvetica\">%@</body>",htmlDirections];
//    [htmlTextview loadHTMLString:htmlDirectionString baseURL:nil];
//    [htmlTextview setBackgroundColor:[UIColor clearColor]];
//    htmlTextview.opaque=NO;
//    [routesDetailView addSubview:htmlTextview];
//    [routesDetailView bringSubviewToFront:htmlTextview];
//
//    [scrollview addSubview:routesDetailView];
//    [scrollview bringSubviewToFront:routesDetailView];
//
//    [self.view setNeedsLayout];
//
//
//}
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
        //        JPSThumbnailAnnotation * temp = (JPSThumbnailAnnotation*)view;
        // NSLog(@"temp title");
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
        // NSLog(@"i = %d", i);
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
- (IBAction)segmentValueChange:(id)sender {
    
    UISegmentedControl * segment  = (UISegmentedControl*)sender;
    if(segment.selectedSegmentIndex == 0)
    {
        self.billTableView.hidden = YES;
        self.orderDetailsTableView.hidden = YES;
        
        self.trackOrderTableView.hidden = NO;
        
    }
    else if(segment.selectedSegmentIndex == 1)// bill
    {
        [self.billTableView reloadData];
        self.billTableView.hidden = NO;
        
        self.trackOrderTableView.hidden = YES;
        self.orderDetailsTableView.hidden = YES;
    }
    else if(segment.selectedSegmentIndex == 2)
    {
        [self.orderDetailsTableView reloadData];
        self.orderDetailsTableView.hidden = NO;
        
        self.billTableView.hidden = YES;
        self.trackOrderTableView.hidden = YES;
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
@end
