w//
//  AddImageOverlay.m
//  AlAmeed
//
//  Created by user on 1/21/14.
//  Copyright (c) 2014 foreigntree. All rights reserved.
//

#import "AddImageOverlay.h"
static ImageOverlay *overlayview;
@implementation AddImageOverlay
+(void)addLoadingInView:(UIView *)view image:(UIImage *)_image{
    
    if(!overlayview)
        overlayview =[[ImageOverlay alloc]   initWithFrame:CGRectMake(0, 0, 320, 520) image:_image view:view];
    
    
    if(![overlayview isDescendantOfView:view]) {
        [overlayview setimage:_image view:view];
        parentview=view;
        
        [view addSubview:overlayview];
        [view bringSubviewToFront:overlayview];
    }
    
    
}


+(void)removeLoadingFromView:(UIView *)view
{
    
    if([overlayview isDescendantOfView:parentview]) {
        
        [overlayview removeFromSuperview];
        parentview=nil;
    }
    
}
+(void)addselector:(UIViewController *)target
{
    [overlayview.closeButton addTarget:self action:@selector(removeLoadingFromView:) forControlEvents:UIControlEventTouchUpInside];
}

@end
