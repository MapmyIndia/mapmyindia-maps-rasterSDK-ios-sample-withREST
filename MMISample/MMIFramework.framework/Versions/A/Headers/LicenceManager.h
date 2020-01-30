//
//  MMISingleton.h
//  MMIFramework
//
//  Created by mac on 16/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LicenceManager : NSObject

+(LicenceManager*)sharedInstance;
@property(nonatomic,strong)NSString* restAPIKey;
@property(nonatomic,strong)NSString* mapSDKKey;

@end
