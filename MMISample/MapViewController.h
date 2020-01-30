//
//  AppDelegate.m
//  MMISampleApp
//
//  Created by mac on 23/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <MMIFramework/MMIFramework.h>
#import "MBProgressHUD.h"
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>

@interface MapViewController : UIViewController<SlideNavigationControllerDelegate,MMIDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet MMIMapView* mapView;
    IBOutlet UIView* vwEvent;
    IBOutlet UILabel* lblMapCenter;
    IBOutlet UILabel* lblTopLeft;
    IBOutlet UILabel* lblTopRight;
    IBOutlet UILabel* lblBottomLeft;
    IBOutlet UILabel* lblBottomRight;
    IBOutlet UILabel* lblZoomLevel;
    IBOutlet UITableView* tblViewAutoSearch;
    int idSelect;
    
    BOOL checkForGeocode;
    BOOL checkForNearby;
    BOOL checkForPlaceDetail;
    NSArray<MapmyIndiaAtlasSuggestion *> * _Nullable arrAutoSearch;

    
}
-(IBAction)selectMenuButton:(id)sender;

@end
