/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ShimmerView.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiViewController.h"
#import "FBShimmeringLayer.h"


#define __layer ((FBShimmeringLayer *)self.layer)

#define LAYER_ACCESSOR(accessor, ctype) \
- (ctype)accessor { \
return [__layer accessor]; \
}

#define LAYER_MUTATOR(mutator, ctype) \
- (void)mutator (ctype)value { \
[__layer mutator value]; \
}

#define LAYER_RW_PROPERTY(accessor, mutator, ctype) \
LAYER_ACCESSOR (accessor, ctype) \
LAYER_MUTATOR (mutator, ctype)


@implementation ItTiShimmerView


+(Class)layerClass
{
    return [FBShimmeringLayer class];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // [self imageView];
    }
    return self;
}


LAYER_RW_PROPERTY(isShimmering, setShimmering:, BOOL)
LAYER_RW_PROPERTY(shimmeringPauseDuration, setShimmeringPauseDuration:, CFTimeInterval)
LAYER_RW_PROPERTY(shimmeringOpacity, setShimmeringOpacity:, CGFloat)
LAYER_RW_PROPERTY(shimmeringSpeed, setShimmeringSpeed:, CGFloat)
LAYER_RW_PROPERTY(shimmeringHighlightWidth, setShimmeringHighlightWidth:, CGFloat)
LAYER_RW_PROPERTY(shimmeringDirection, setShimmeringDirection:, FBShimmerDirection)
LAYER_ACCESSOR(shimmeringFadeTime, CFTimeInterval)
LAYER_RW_PROPERTY(shimmeringBeginFadeDuration, setShimmeringBeginFadeDuration:, CFTimeInterval)
LAYER_RW_PROPERTY(shimmeringEndFadeDuration, setShimmeringEndFadeDuration:, CFTimeInterval)


@end
