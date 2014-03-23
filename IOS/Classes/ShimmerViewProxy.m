/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ShimmerView.h"
#import "ShimmerViewProxy.h"
#import "TiUtils.h"


#define __view ((ItTiShimmerShimmeringView *)self.view)


@implementation ItTiShimmerShimmeringViewProxy {}

/*

 @synthesize shimmering = _shimmering;
 @synthesize shimmeringPauseDuration = _shimmeringPauseDuration;
 @synthesize shimmeringOpacity = _shimmeringOpacity;
 @synthesize shimmeringSpeed = _shimmeringSpeed;
 @synthesize shimmeringHighlightWidth = _shimmeringHighlightWidth;
 @synthesize shimmeringDirection = _shimmeringDirection;
 @synthesize shimmeringFadeTime = _shimmeringFadeTime;
 @synthesize shimmeringBeginFadeDuration = _shimmeringBeginFadeDuration;
 @synthesize shimmeringEndFadeDuration = _shimmeringEndFadeDuration;
 
 */


- (void)startShimmering:(id)args
{
    ENSURE_UI_THREAD(startShimmering, args);
    __view.shimmering = YES;
}

- (void)stopShimmering:(id)args
{
    ENSURE_UI_THREAD(stopShimmering, args);
    __view.shimmering = NO;
}

- (void)setShimmering:(id)args
{
    ENSURE_UI_THREAD(setShimmering, args);
    __view.shimmering = [TiUtils boolValue:args def:NO];
}

- (void)setShimmeringOpacity:(id)args
{
    ENSURE_UI_THREAD(setShimmeringOpacity, args);
    __view.shimmeringOpacity = [TiUtils floatValue:args];
}

- (void)setShimmeringSpeed:(id)args
{
    ENSURE_UI_THREAD(setShimmeringSpeed, args);
    __view.shimmeringSpeed = [TiUtils floatValue:args];
}

- (void)setShimmeringHighlightWidth:(id)args
{
    ENSURE_UI_THREAD(setShimmeringHighlightWidth, args);
    __view.shimmeringHighlightWidth = [TiUtils floatValue:args];
}

- (void)setShimmeringDirection:(id)args
{
    NSString *direction = [[TiUtils stringValue:args] lowercaseString];
    if ([direction isEqualToString:@"left"])
    {
        [self setViewShimmeringDirection:FBShimmerDirectionLeft];
    }
    else if ([direction isEqualToString:@"right"])
    {
        [self setViewShimmeringDirection:FBShimmerDirectionRight];
    }
    else {
        [self throwException:@"Illegal argument"
                   subreason:@"direction must be either 'right' or 'left'"
                    location:CODELOCATION];
    }
}

- (void)setViewShimmeringDirection:(FBShimmerDirection)direction
{
    ENSURE_UI_THREAD(setViewShimmeringDirection, direction);
    __view.shimmeringDirection = direction;
}

- (id)shimmering
{
    return [NSNumber numberWithBool:[__view isShimmering]];
}

- (id)shimmeringOpacity
{
    return [NSNumber numberWithFloat:__view.shimmeringOpacity];
}

- (id)shimmeringSpeed
{
    return [NSNumber numberWithFloat:__view.shimmeringSpeed];
}

- (id)shimmeringHighlightWidth
{
    return [NSNumber numberWithFloat:__view.shimmeringHighlightWidth];
}

- (id)shimmeringDirection
{
    if (__view.shimmeringDirection == FBShimmerDirectionLeft)
    {
        return @"left";
    }
    else if (__view.shimmeringDirection == FBShimmerDirectionRight)
    {
        return @"right";
    }
    else
    {
        return nil;
    }
}

@end
