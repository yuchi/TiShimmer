/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItScsoftShimmerShimmerView.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiViewController.h"
//#import "TiUIImageViewProxy.h"
#import "FBShimmeringView.h"

UIViewController * ControllerForViewProxy(TiViewProxy * proxy)
{
    [[proxy view] setAutoresizingMask:UIViewAutoresizingNone];
    
    //make the proper resize !
    TiThreadPerformOnMainThread(^{
        [proxy windowWillOpen];
        [proxy reposition];
        [proxy windowDidOpen];
    },YES);
    return [[TiViewController alloc] initWithViewProxy:proxy];
}


@implementation ItScsoftShimmerShimmerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // [self imageView];
    }
    return self;
}

-(FBShimmeringView *)shimmergingView
{
    if(shimmeringView == nil){
        shimmeringView = [[FBShimmeringView alloc] initWithFrame:[self frame]];
        

        if([self.proxy valueForUndefinedKey:@"label"] != nil){
            NSDictionary *args = [self.proxy valueForUndefinedKey:@"label"];
            UILabel *label =[[UILabel alloc] initWithFrame:shimmeringView.bounds];
            label.text =[TiUtils stringValue:@"text" properties:args def:@""];
            label.textAlignment = [TiUtils intValue:[TiUtils stringValue:@"textAlign" properties:args def:@"0"]];
            label.textColor = [[TiUtils colorValue:[TiUtils stringValue:@"color" properties:args def:@"black"]] _color];
            label.font = [UIFont fontWithName:
                          [TiUtils stringValue:@"fontFamily" properties:args def:@"HelveticaNeue"]
                                         size:[TiUtils floatValue:[TiUtils stringValue:@"fontSize" properties:args def:@"40.0"]]];
            shimmeringView.contentView = label;
        }
        
        
        
        if([self.proxy valueForUndefinedKey:@"subview"] != nil){
            TiViewProxy *ob = [self.proxy valueForUndefinedKey:@"subview"];
            shimmeringView.contentView = ob.view;
        }
       
       
        
        if([self.proxy valueForUndefinedKey:@"speed"] != nil){
            shimmeringView.shimmeringSpeed = fmaxf(0.0, fminf(1000.0,  [TiUtils floatValue:[self.proxy valueForUndefinedKey:@"speed"]]));
        }else{
            shimmeringView.shimmeringSpeed = 50.0f;
        }
        
        if([self.proxy valueForUndefinedKey:@"opacity"] != nil){
            shimmeringView.shimmeringOpacity = fmaxf(0.0, fminf(1.0,[TiUtils floatValue:[self.proxy valueForUndefinedKey:@"opacity"]]));
        }else{
            shimmeringView.shimmeringOpacity = 0.5f;
        }
        
        shimmeringView.shimmering = YES;
        
        [self addSubview:shimmeringView];
    }
    return shimmeringView;
}



-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (shimmeringView!=nil)
    {
        [TiUtils setView:shimmeringView positionRect:bounds];
        
    }
}

-(void)setSpeed_:(id)speed
{
    
     [[self shimmergingView] setShimmeringSpeed:fmaxf(0.0, fminf(1000.0, [TiUtils floatValue:speed]))];
}

-(void)setOpacity_:(id)opacity
{
     [[self shimmergingView] setShimmeringOpacity:fmaxf(0.0, fminf(1.0, [TiUtils floatValue:opacity]))];
}

-(void)setBeginfade_:(id)beginfade
{
    [[self shimmergingView] setShimmeringBeginFadeDuration:fmaxf(0.0, fminf(1.0, [TiUtils floatValue:beginfade]))];
}

-(void)setEndfade_:(id)endfade
{
     [[self shimmergingView] setShimmeringEndFadeDuration:fmaxf(0.0, fminf(1.0, [TiUtils floatValue:endfade]))];
}
@end
