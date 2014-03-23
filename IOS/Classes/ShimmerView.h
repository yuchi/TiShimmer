/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "FBShimmering.h"
#import "FBShimmeringLayer.h"


#define LAYER_ACCESSOR_PROTOTYPE(accessor, ctype) \
- (ctype)accessor;

#define LAYER_MUTATOR_PROTOTYPE(mutator, ctype) \
- (void)mutator (ctype)value;

#define LAYER_RW_PROPERTY_PROTOTYPE(accessor, mutator, ctype) \
LAYER_ACCESSOR_PROTOTYPE (accessor, ctype) \
LAYER_MUTATOR_PROTOTYPE (mutator, ctype)

@interface ItTiShimmerShimmeringView : TiUIView <FBShimmering> {}

LAYER_RW_PROPERTY_PROTOTYPE(isShimmering, setShimmering:, BOOL)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringPauseDuration, setShimmeringPauseDuration:, CFTimeInterval)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringOpacity, setShimmeringOpacity:, CGFloat)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringSpeed, setShimmeringSpeed:, CGFloat)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringHighlightWidth, setShimmeringHighlightWidth:, CGFloat)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringDirection, setShimmeringDirection:, FBShimmerDirection)
LAYER_ACCESSOR_PROTOTYPE(shimmeringFadeTime, CFTimeInterval)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringBeginFadeDuration, setShimmeringBeginFadeDuration:, CFTimeInterval)
LAYER_RW_PROPERTY_PROTOTYPE(shimmeringEndFadeDuration, setShimmeringEndFadeDuration:, CFTimeInterval)

@end
