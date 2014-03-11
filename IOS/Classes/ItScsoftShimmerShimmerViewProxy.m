/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiUtils.h"
#import "FBShimmeringLayer.h"
#import "ItScsoftShimmerShimmerView.h"
#import "ItScsoftShimmerShimmerViewProxy.h"

@implementation ItScsoftShimmerShimmerViewProxy


- (void) add: (id) arg
{

    NSLog(@"Bah");

    [super add:arg];

    if (![NSThread isMainThread])
    {
        return;
    }

    if ([arg isKindOfClass:[NSArray class]])
	{
		arg = [arg objectAtIndex:0];
	}

    NSLog(@"Mhh");

    ItScsoftShimmerShimmerView * theView = (ItScsoftShimmerShimmerView *)[self view];
    FBShimmeringLayer * theLayer = (FBShimmeringLayer *)theView.layer;

    theLayer.contentLayer = [arg view].layer;
}


@end
