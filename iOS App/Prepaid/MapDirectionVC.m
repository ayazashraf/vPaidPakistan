//
//  MapDirectionVC.m
//  Prepaid
//
//  Created by Ahmed Shahid on 03/04/2017.
//  Copyright © 2017 Foreign Tree System. All rights reserved.
//

#import "MapDirectionVC.h"
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "JPSThumbnailAnnotation.h"
@interface MapDirectionVC ()
{
    NSDictionary * googleDataForDrive;
    NSDictionary * googleDataForWalk;
    BOOL isDrive;
}
@property (nonatomic,assign) CLLocationCoordinate2D Destination;
@property (nonatomic,strong) MKPolyline *polyLine;
@property (nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation MapDirectionVC
@synthesize Destination, polyLine, geocoder;
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self ChnageLabelAlignmentToLeft:YES];
    isDrive = YES;
    self.eathViewLabel.textColor = [UIColor blackColor];
    [self.directionMapView setDelegate:self];
    [self StyleMyBtn:self.carBtn];
    [self StyleMyBtn:self.walkBtn];
    //[self StyleMyBtn:];
    self.earthviewView.layer.cornerRadius = 5;
    self.walkBtn.layer.borderColor = [UIColor clearColor].CGColor;
    
    Destination.latitude = self.lat;
    Destination.longitude = self.lng;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        [self.directionMapView addAnnotations:[self annotations]];
    });

    
    [self makeRequestForGoogleApi];
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.earthviewView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.earthviewView.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.earthviewView addSubview:blurEffectView];
    } else {
        self.earthviewView.backgroundColor = [UIColor blackColor];
    }
    
    [self.earthviewView addSubview:self.earthViewSwitch];
    [self.earthviewView addSubview:self.eathViewLabel];
}
-(void)StyleMyBtn:(UIView*)btnView;
{
    btnView.layer.borderWidth = 2;
    btnView.layer.borderColor = [UIColor blackColor].CGColor;
    btnView.layer.cornerRadius = 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBACTIONS
- (IBAction)doneBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)earthViewSwitchChange:(id)sender {
    if(self.earthViewSwitch.on)
    {
        self.directionMapView.mapType = MKMapTypeSatellite;
        self.eathViewLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.directionMapView.mapType = MKMapTypeStandard;
        self.eathViewLabel.textColor = [UIColor blackColor];
    }
    
    [self DrawPolyLine];
}
- (IBAction)walkBtnPress:(id)sender {
   // [self ChnageLabelAlignmentToLeft:NO];
    if(polyLine)
        [self.directionMapView removeOverlay:polyLine];
    self.carBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.walkBtn.layer.borderColor = [UIColor blackColor].CGColor;
    isDrive = NO;
    if(!googleDataForWalk)
        [self makeRequestForGoogleApi];
    else
        [self ParseGoogleData];
}
- (IBAction)carBtnPress:(id)sender {
    //[self ChnageLabelAlignmentToLeft:YES];
    if(polyLine)
        [self.directionMapView removeOverlay:polyLine];
    self.walkBtn.layer.borderColor = [UIColor clearColor].CGColor;
    self.carBtn.layer.borderColor = [UIColor blackColor].CGColor;
    isDrive = YES;
    if(!googleDataForDrive)
        [self makeRequestForGoogleApi];
    else
        [self ParseGoogleData];
}
-(void)ChnageLabelAlignmentToLeft:(BOOL)yes
{
    if(yes)
    {
        [self.distanceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.timeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.distTextLabel setTextAlignment:NSTextAlignmentLeft];
        [self.timeTextLabel setTextAlignment:NSTextAlignmentLeft];
    }
    else
    {
        [self.distanceLabel setTextAlignment:NSTextAlignmentRight];
        [self.timeLabel setTextAlignment:NSTextAlignmentRight];
        [self.distTextLabel setTextAlignment:NSTextAlignmentRight];
        [self.timeTextLabel setTextAlignment:NSTextAlignmentRight];
    }
}
#pragma mark - API CALLING
- (void) makeRequestForGoogleApi
{
    
    if(polyLine)
        [self.directionMapView removeOverlay:polyLine];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //https://maps.googleapis.com/maps/api/directions/json?origin=24.867530,67.080875&destination=24.882672,67.067472&sensor=true&mode=driving&alternatives=false
    NSString *string = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=24.867530,67.080875&destination=%f,%f&sensor=true&mode=%@&alternatives=false", Destination.latitude, Destination.longitude, [self returnMeMode:isDrive]];
    NSLog(@"MapDirectionVC: %@", string);
    NSURL *url = [NSURL URLWithString:string];
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
                    if(isDrive)
                        
                        googleDataForDrive = [[NSDictionary alloc] initWithDictionary:data];
                    
                    else
                        googleDataForWalk = [[NSDictionary alloc] initWithDictionary:data];
                    
                    [self ParseGoogleData];
                }
                
            }
            else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"internal server error..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            
        }else if ([responseObject isKindOfClass:[NSArray class]]){
            //This is an NSArray, you cannot call 'valueForKey' on this responseObject
        }
        
        
        
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"Error: %@", error);
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"no internet connection.." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }];
    
}
-(void)ParseGoogleData
{
    NSDictionary * dicTemp = [[NSDictionary alloc] init];
    if(isDrive)
        dicTemp = googleDataForDrive;
    else
        dicTemp = googleDataForWalk;

        self.distanceLabel.text = [[[[[[dicTemp valueForKey:@"routes"] firstObject] valueForKey:@"legs"] firstObject] valueForKey:@"distance"] valueForKey:@"text"];
        self.timeLabel.text = [[[[[[dicTemp valueForKey:@"routes"] firstObject] valueForKey:@"legs"] firstObject] valueForKey:@"duration"] valueForKey:@"text"];
    [self DrawPolyLine];
//    NSString *overviewPolyline =[[[[dicTemp objectForKey: @"routes"] firstObject]valueForKey:@"overview_polyline"] valueForKey:@"points"];
//        
//        NSMutableString *encode=[[NSMutableString alloc]initWithString:overviewPolyline];
//        NSMutableArray *pointarray=[[NSMutableArray alloc]init];
//        pointarray=[self decodePolyLine:encode];
//        
//        //NSLog(@"%@",[pointarray description]);
//        NSInteger numberOfSteps = pointarray.count;
//        
//        
//        if (numberOfSteps>0) {
//            
//            CLLocationCoordinate2D coordinates[numberOfSteps];
//            for (NSInteger index = 0; index < numberOfSteps; index++) {
//                CLLocation *location = [pointarray objectAtIndex:index];
//                CLLocationCoordinate2D coordinate = location.coordinate;
//                
//                coordinates[index] = coordinate;
//            }
//            polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
//            
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.directionMapView addOverlay:polyLine];
//                [self.directionMapView setNeedsDisplay];
//            });
//            
//            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(Destination, 500, 500);
//            [self.directionMapView setRegion:[self.directionMapView regionThatFits:region] animated:YES];
//        }
}
#pragma mark MKPolyline delegate functions
-(void)DrawPolyLine
{
    if(polyLine)
        [self.directionMapView removeOverlay:polyLine];
    NSDictionary * dicTemp = [[NSDictionary alloc] init];

    if(isDrive)
        dicTemp = googleDataForDrive;
    else
        dicTemp = googleDataForWalk;
    
    NSString *overviewPolyline =[[[[dicTemp objectForKey: @"routes"] firstObject]valueForKey:@"overview_polyline"] valueForKey:@"points"];
    
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
            [self.directionMapView addOverlay:polyLine];
            [self.directionMapView setNeedsDisplay];
        });
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(Destination, 500, 500);
        [self.directionMapView setRegion:[self.directionMapView regionThatFits:region] animated:YES];
    }
}
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
//    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
//    polylineView.strokeColor = [UIColor blackColor];
//    polylineView.lineWidth = 10.0;
//    return polylineView;
    if(!isDrive)
    {
        MKPolylineRenderer *renderer =[[MKPolylineRenderer alloc] initWithPolyline:overlay];
        if(self.earthViewSwitch.on)
            renderer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        else
            renderer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        renderer.lineWidth = 3.0;
        renderer.lineDashPattern = @[@2, @5];
        //renderer.alpha = 0.5;
        return (MKOverlayView*)renderer;
    }
    else
    {
        MKPolylineRenderer *renderer =[[MKPolylineRenderer alloc] initWithPolyline:overlay];
        if(!self.earthViewSwitch.on)
            renderer.strokeColor = [UIColor blackColor];
        else
            renderer.strokeColor = [UIColor whiteColor];
        
        renderer.lineWidth = 5.0;
        return (MKOverlayView*)renderer;
    }
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

#pragma mark - ANNOTATION
- (NSArray *)annotations {
    // Empire State Building
    JPSThumbnail *resturantAnno = [[JPSThumbnail alloc] init];
    resturantAnno.image = [UIImage imageNamed:@"kfcLogo1"];
    resturantAnno.title = @"KFC";
    resturantAnno.subtitle = @"KFC karachi";
    //empire.coordinate = CLLocationCoordinate2DMake(40.75f,-73.99f);
    resturantAnno.coordinate = CLLocationCoordinate2DMake(Destination.latitude,Destination.longitude);
    resturantAnno.disclosureBlock = ^{
        
    };
    
    // Apple HQ
    JPSThumbnail *userAnno = [[JPSThumbnail alloc] init];
    userAnno.image = [UIImage imageNamed:@"profile"];
    userAnno.title = @"Your location";
    userAnno.subtitle = @"your location";
    userAnno.coordinate = CLLocationCoordinate2DMake(24.867530, 67.080875);
    userAnno.disclosureBlock = ^{};
    
    //    // Parliament of Canada
    //    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    //    ottawa.image =nil;
    //    ottawa.title = @"Parliament of Canada";
    //    ottawa.subtitle = @"Oh Canada!";
    //    ottawa.coordinate = CLLocationCoordinate2DMake(45.43f, -75.70f);
    //    ottawa.disclosureBlock = ^{};
    
    return @[[JPSThumbnailAnnotation annotationWithThumbnail:resturantAnno],
             [JPSThumbnailAnnotation annotationWithThumbnail:userAnno],
             /*[JPSThumbnailAnnotation annotationWithThumbnail:ottawa]*/];
    
    
}
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
-(NSString*)returnMeMode:(BOOL)isDriveBool
{
    if(isDriveBool)
        return @"driving";
    else
        return @"walking";
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
