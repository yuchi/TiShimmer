/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItScsoftShimmerShimmerView.h"
#import "TiUtils.h"
#import "FBShimmeringView.h"

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

-(void)setLabel_:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    

    UILabel *label =[[UILabel alloc] initWithFrame:shimmeringView.bounds];
    label.text =[TiUtils stringValue:@"text" properties:args def:@""];
    label.textAlignment = [TiUtils intValue:[TiUtils stringValue:@"textAlign" properties:args def:@"0"]];
    label.textColor = [[TiUtils colorValue:[TiUtils stringValue:@"color" properties:args def:@"black"]] _color];
    label.font = [UIFont fontWithName:
                         [TiUtils stringValue:@"fontFamily" properties:args def:@"HelveticaNeue"]
                         size:[TiUtils floatValue:[TiUtils stringValue:@"fontSize" properties:args def:@"40.0"]]];
    
    FBShimmeringView *s = [self shimmergingView];
    s.shimmeringSpeed = 100;
    s.shimmeringOpacity = 0.5;
    s.contentView = label;
    s.shimmering = YES;
 //    NSLog(@"[INFO] 2: %f, %f",s.shimmeringSpeed ,  fmaxf(0.0, fminf(1000.0, s.shimmeringSpeed)));
   // NSLog(@"[INFO] Speed: %f, %f",s.shimmeringSpeed ,  fmaxf(0.0, fminf(1000.0, s.shimmeringSpeed)));

    //shimmeringBeginFadeDuration
    //shimmeringSpeed
    //shimmeringOpacity
}

@end
