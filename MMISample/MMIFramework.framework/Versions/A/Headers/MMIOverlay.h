//
//  MMIOverlay.h
//  MMIFramework
//
//  Created by mac on 21/07/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMIOverlay : NSObject
/** @name Accessing Drawing Properties */

/** The circle's underlying shape layer. */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

/** The circle's line color. Defaults to black. */
@property (nonatomic, strong) UIColor *lineColor;

/** The circle's fill color. Defaults to blue with a 25% alpha value. */
@property (nonatomic, strong) UIColor *fillColor;

/** The fill pattern image of the circle. If set, the fillColor is set to `nil`. */
@property (nonatomic, strong) UIImage *fillPatternImage;

/** The radius of the circle in projected meters. Regardless of map zoom, the circle will change visible size to continously represent this radius on the map. */
@property (nonatomic, assign) CGFloat radiusInMeters;

/** The circle's line width. Defaults to 2.0. */
@property (nonatomic, assign) CGFloat lineWidthInPixels;
@end
