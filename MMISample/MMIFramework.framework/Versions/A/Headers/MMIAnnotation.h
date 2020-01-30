//
//  MMIAnnotation.h
//  MMIFramework
//
//  Created by mac on 17/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MMIOverlay.h"
@interface MMIAnnotation : MMIOverlay
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* subTitle;
@property(nonatomic,strong)UIImage* markerImage;
@property(nonatomic,assign) CGPoint anchorPoint;
@property(nonatomic,assign)CGSize makerSize;
@property(assign)BOOL canShowCallout;
@property(nonatomic,assign)int tag;
@property(assign)float opacity;
@property (nonatomic, strong) UIView *rightCalloutAccessoryView;
@property (nonatomic, strong) UIView *leftCalloutAccessoryView;

@end
