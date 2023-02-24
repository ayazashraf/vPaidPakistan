//
//  MyAnnotation.h
//  Qnet
//
//  Created by user on 5/23/13.
//  Copyright (c) 2013 foreigntree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject<MKAnnotation>
@property (nonatomic,copy)NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *subtitle;
@end
