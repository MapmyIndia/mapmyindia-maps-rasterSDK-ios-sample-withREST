//
//  AppDelegate.m
//  MMISampleApp
//
//  Created by mac on 23/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import "MapViewController.h"
#import <MMIFramework/MMIFramework.h>
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>


#define kAPIUrl @"https://apis.mapmyindia.com/advancedmaps/v1"
@interface MapViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UIView *ViewDirections;
    IBOutlet UISearchBar *searchBar;
    
    IBOutlet UITextField *txtStartDirection1;
    
    IBOutlet UITextField *txtStartDirection2;
    
    IBOutlet UITextField *txtDestination1;
    
    IBOutlet UITextField *txtDestination2;
    
    IBOutlet UIView *viewDistance;
    
    IBOutlet UITextField *txtCenterLat;
    
    IBOutlet UITextField *txtCenterLong;
    
    IBOutlet UITextField *txtOtherPoint1;
    
    IBOutlet UITextField *txtOtherPoint2;
    
    IBOutlet UILabel *lblDistanceTime;
    
    IBOutlet UITextField *txtReverseGeocode2;
    IBOutlet UITextField *txtReverseGeocode1;
    
    IBOutlet UILabel *lblRevreseGeoCodeResult;
    
    IBOutlet UIView *viewReverseGeoCode;
}

- (IBAction)btnReverseGeoCodeAction:(id)sender;


- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDistance:(id)sender;
@end

@implementation MapViewController

{
    BOOL usingSearchBarForAutoSuggest;
    NSArray * autoSuggestResults;
}
- (IBAction)btnDirectionSearch:(id)sender {
    
    [self directionManager];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [searchBar resignFirstResponder];
    
}
- (void)dismissKeyboard
{
    [searchBar resignFirstResponder];
}
-(void)mapViewRegionDidChange:(MMIMapView *)mapView;
{
}
-(void)afterMapZoom:(MMIMapView *)map byUser:(BOOL)wasUserAction;
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
     ViewDirections.hidden=YES;
     viewDistance.hidden=YES;
     viewReverseGeoCode.hidden=YES;
    
    checkForGeocode=NO;
    checkForNearby=NO;
    checkForPlaceDetail=NO;
    searchBar.hidden=YES;
    tblViewAutoSearch.hidden=YES;
    
    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    //[self.view addGestureRecognizer:tap];

    [mapView setZoom:4];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMap:) name:@"reloadMap" object:nil];
    [SlideNavigationController sharedInstance].portraitSlideOffset=115;
    [self.view bringSubviewToFront:vwEvent];
    [self callMarker];
    vwEvent.hidden=YES;
    mapView.showUserLocation=YES;
   
}


#pragma mark - Notification

- (void)loadMap:(NSNotification *)notification {
   
    usingSearchBarForAutoSuggest=NO;
    autoSuggestResults=nil;
    
    
    vwEvent.hidden=YES;
    ViewDirections.hidden=YES;
    viewDistance.hidden=YES;
    viewReverseGeoCode.hidden=YES;
    

    mapView.isAddOverlay=NO;
    searchBar.hidden=YES;
    searchBar.text=@"";
    arrAutoSearch = nil;
    tblViewAutoSearch.hidden=YES;
    [tblViewAutoSearch reloadData];
    checkForGeocode=NO;
    checkForNearby=NO;
    checkForPlaceDetail=NO;
    
    idSelect=[[notification.userInfo objectForKey:@"index"]intValue];
    if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"0"]){
        [mapView removeAllAnnotations];
        mapView.clusteringEnabled=NO;
        [self callMarker];
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"1"]){
        [mapView removeAllAnnotations];
        [self drawPolyLine];
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"2"]){
        [mapView removeAllAnnotations];
        vwEvent.hidden=NO;
        [mapView setCenterCoordinate:CLLocationCoordinate2DMake(28.549506, 77.267938)];
        
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"3"]){
        [mapView removeAllAnnotations];
        mapView.clusteringEnabled=YES;
        [self callMultipleMarkers];
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"4"]){
        [mapView removeAllAnnotations];
        mapView.showUserLocation=YES;
        [mapView setCenterCoordinate:mapView.userLocation];
        
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"5"]){
        [mapView removeAllAnnotations];
        mapView.clusteringEnabled=NO;
        [self callMultipleMarkers];
        
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"6"]){
        [mapView removeAllAnnotations];
        //  mapView.isAddOverlay=YES;
        // [self callMultipleMarkers];
        searchBar.hidden=NO;
        checkForGeocode=YES;
        NSString *searchQuery = @"India";
        searchBar.text = searchQuery;
        [self callGeoAPI:searchQuery];
    }
    
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"7"]){
        [mapView removeAllAnnotations];
        [self drawPolygon];
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"8"]){
        [mapView removeAllAnnotations];
        ViewDirections.hidden=NO;
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"9"]){
        [mapView removeAllAnnotations];
        viewDistance.hidden=NO;
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"10"]){
        [mapView removeAllAnnotations];
        viewReverseGeoCode.hidden=NO;
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"11"]){
        [mapView removeAllAnnotations];
        searchBar.hidden=NO;
        checkForNearby=YES;
        NSString *searchQuery = @"Hotel";
        searchBar.text = searchQuery;
        [self callNearby:searchQuery];
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"12"]){
        [mapView removeAllAnnotations];
        searchBar.hidden=NO;
        tblViewAutoSearch.hidden=NO;        
    }
    else if([[notification.userInfo objectForKey:@"index"] isEqualToString:@"13"]){
        [mapView removeAllAnnotations];
        searchBar.hidden=NO;
        checkForPlaceDetail=YES;
        NSString *eLoc = @"mmi000";
        searchBar.text = eLoc;
        [self callPlaceDetail:eLoc];
    }
  

    [ mapView setClipsToBounds:YES];
    
}


-(void)alertShow:(NSString *)Message
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)callGeoAPI:(NSString*)placeName{
    MapmyIndiaGeocodeManager * geocodeManager = [MapmyIndiaGeocodeManager sharedManager];
    MapmyIndiaForwardGeocodeOptions *forOptions = [[MapmyIndiaForwardGeocodeOptions alloc] initWithQuery: placeName withRegion:MMIRegionTypeIdentifierDefault];
    
    [geocodeManager geocodeWithOptions:forOptions completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self addMarkersFromGeocodedPlacemark:placemarks];
    }];
}

-(void)callNearby:(NSString*)searchQuery{
    MapmyIndiaNearByManager * nearByManager = [MapmyIndiaNearByManager sharedManager];
    MapmyIndiaNearbyAtlasOptions *nearByOptions = [[MapmyIndiaNearbyAtlasOptions alloc] initWithQuery:searchQuery location:[[CLLocation alloc] initWithLatitude: mapView.centerCoordinate.latitude longitude: mapView.centerCoordinate.longitude] withRegion:MMIRegionTypeIdentifierDefault];
    nearByOptions.bounds = [[MapmyIndiaRectangularRegion alloc] initWithTopLeft:CLLocationCoordinate2DMake(28.563838, 77.244345) bottomRight:CLLocationCoordinate2DMake(28.541898, 77.294514)];
    [nearByManager getNearBySuggestionsWithOptions:nearByOptions completionHandler:^(NSArray<MapmyIndiaAtlasSuggestion *> * _Nullable suggestions, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        } else if (suggestions.count > 0) {
            [self addMarkersFromSuggestions:suggestions];
        } else {
            NSLog(@"No results");
        }
    }];
}

-(void)callPlaceDetail:(NSString*)searchQuery{
    MapmyIndiaPlaceDetailManager * placeDetailManager = [MapmyIndiaPlaceDetailManager sharedManager];
    MapmyIndiaPlaceDetailGeocodeOptions *placeOptions = [[MapmyIndiaPlaceDetailGeocodeOptions alloc]  initWithPlaceId:searchQuery withRegion:MMIRegionTypeIdentifierDefault];
    [placeDetailManager getPlaceDetailWithOptions:placeOptions completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (placemarks.count > 0) {
            [self addMarkersFromGeocodedPlacemark:placemarks];
        } else {
            NSLog(@"No results");
        }
    }];
}

-(void)callAutoSuggest:(NSString*)searchQuery{
    MapmyIndiaAutoSuggestManager * autoSuggestManager = [MapmyIndiaAutoSuggestManager sharedManager];
    MapmyIndiaAutoSearchAtlasOptions *autoSearchOptions = [[MapmyIndiaAutoSearchAtlasOptions alloc] initWithQuery:searchQuery withRegion:MMIRegionTypeIdentifierDefault];
    autoSearchOptions.location = [[CLLocation alloc] initWithLatitude: mapView.centerCoordinate.latitude longitude: mapView.centerCoordinate.longitude];
    autoSearchOptions.zoom = [NSNumber numberWithFloat: mapView.zoom];
//    autoSearchOptions.includeTokenizeAddress = YES;
//    autoSearchOptions.filter = [[MapmyIndiaElocFilter alloc] initWithPlaceId:@"TAVI5S"];
//    autoSearchOptions.filter = [[MapmyIndiaBoundsFilter alloc] initWithBounds:[[MapmyIndiaRectangularRegion alloc] initWithTopLeft:CLLocationCoordinate2DMake(28.563838, 77.244345) bottomRight:CLLocationCoordinate2DMake(28.541898, 77.294514)]];
    [autoSuggestManager getAutoSuggestionsWithOptions:autoSearchOptions completionHandler:^(NSArray<MapmyIndiaAtlasSuggestion *> * _Nullable suggestions, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (suggestions.count > 0) {
            arrAutoSearch = suggestions;
            [tblViewAutoSearch reloadData];
        } else {
            NSLog(@"No results");
        }
    }];
}

-(void)addMarkersFromSuggestions:(NSArray<MapmyIndiaAtlasSuggestion *> *)array{
    NSMutableArray* arrAnnotations=[[NSMutableArray alloc] initWithCapacity:0];
    for(int i=0;i<array.count;i++){
        MapmyIndiaAtlasSuggestion* dict=[array objectAtIndex:i];
        MMIAnnotation* Annotation=[[MMIAnnotation alloc] init];
        Annotation.latitude=[dict.latitude doubleValue];
        Annotation.longitude=[dict.longitude doubleValue];
        Annotation.title= [NSString stringWithFormat:@"%@ %@",dict.placeName, dict.placeAddress];
        Annotation.canShowCallout=YES;
        // Annotation.markerImage=carIcon;
        //  Annotation.makerSize=CGSizeMake(64, 64);
        [arrAnnotations addObject:Annotation];
    }
    [mapView addAnnotations:arrAnnotations];
}


- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    if (checkForGeocode || checkForNearby || checkForPlaceDetail) {
        [mapView removeAllAnnotations];
        //Perform the JSON query.
        if (checkForGeocode) {
         [self callGeoAPI:theSearchBar.text];
        } else if (checkForNearby) {
            [self callNearby:theSearchBar.text];
        } else if (checkForPlaceDetail) {
            [self callPlaceDetail:theSearchBar.text];
        }
        //Hide the keyboard.
        [searchBar resignFirstResponder];
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
    [self.view endEditing:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    if ([searchText length] > 2) {
        if (!checkForGeocode && !checkForNearby && !checkForPlaceDetail) {
            [self callAutoSuggest:searchBar.text];
        }
    }
}



#pragma mark - Action And Method


-(IBAction)selectMenuButton:(id)sender{
    
    [searchBar resignFirstResponder];
    [[SlideNavigationController sharedInstance] toggleLeftMenu];
    
}
-(void)addMarkers:(NSArray*)array{
    if(mapView.isAddOverlay==YES){
        
        NSMutableArray* arrAnnotations=[[NSMutableArray alloc] initWithCapacity:0];
        for(int i=0;i<array.count;i++){
            NSDictionary* dict=[array objectAtIndex:i];
            MMIAnnotation* Annotation=[[MMIAnnotation alloc] init];
            Annotation.latitude=[[dict objectForKey:@"lat"] doubleValue];
            Annotation.longitude=[[dict objectForKey:@"lng"] doubleValue];
            Annotation.title=[dict objectForKey:@"city"] ;
            Annotation.lineColor=[UIColor brownColor];
            Annotation.fillColor=[UIColor colorWithRed:.5 green:.466 blue:.733 alpha:.25];
            Annotation.radiusInMeters=500;
            Annotation.lineWidthInPixels=5;
            
            [arrAnnotations addObject:Annotation];
        }
        [mapView addAnnotations:arrAnnotations];
        
    }
    
    else{
        NSMutableArray* arrAnnotations=[[NSMutableArray alloc] initWithCapacity:0];
       // UIImage *carIcon=[UIImage imageNamed:@"icon.jpg"];
        
        for(int i=0;i<array.count;i++){
            NSDictionary* dict=[array objectAtIndex:i];
            MMIAnnotation* Annotation=[[MMIAnnotation alloc] init];
            Annotation.latitude=[[dict objectForKey:@"lat"] doubleValue];
            Annotation.longitude=[[dict objectForKey:@"lng"] doubleValue];
            Annotation.title=[dict objectForKey:@"city"] ;
            Annotation.canShowCallout=YES;
           // Annotation.markerImage=carIcon;
          //  Annotation.makerSize=CGSizeMake(64, 64);
            [arrAnnotations addObject:Annotation];
        }
        [mapView addAnnotations:arrAnnotations];
    }
}

-(void)addMarkersFromGeocodedPlacemark:(NSArray<MapmyIndiaGeocodedPlacemark *> *)array{
    if(mapView.isAddOverlay==YES){
        
        NSMutableArray* arrAnnotations=[[NSMutableArray alloc] initWithCapacity:0];
        for(int i=0;i<array.count;i++){
            MapmyIndiaGeocodedPlacemark * dict=[array objectAtIndex:i];
            MMIAnnotation* Annotation=[[MMIAnnotation alloc] init];
            Annotation.latitude=[dict.latitude doubleValue];
            Annotation.longitude=[dict.longitude doubleValue];
            Annotation.title=dict.formattedAddress ;
            Annotation.lineColor=[UIColor brownColor];
            Annotation.fillColor=[UIColor colorWithRed:.5 green:.466 blue:.733 alpha:.25];
            Annotation.radiusInMeters=500;
            Annotation.lineWidthInPixels=5;
            
            [arrAnnotations addObject:Annotation];
        }
        [mapView addAnnotations:arrAnnotations];
        
    }
    
    else{
        NSMutableArray* arrAnnotations=[[NSMutableArray alloc] initWithCapacity:0];
        // UIImage *carIcon=[UIImage imageNamed:@"icon.jpg"];
        
        for(int i=0;i<array.count;i++){
            MapmyIndiaGeocodedPlacemark* dict=[array objectAtIndex:i];
            MMIAnnotation* Annotation=[[MMIAnnotation alloc] init];
            Annotation.latitude=[dict.latitude doubleValue];
            Annotation.longitude=[dict.longitude doubleValue];
            Annotation.title= [NSString stringWithFormat:@"%@",dict.poi];
            Annotation.canShowCallout=YES;
            // Annotation.markerImage=carIcon;
            //  Annotation.makerSize=CGSizeMake(64, 64);
            [arrAnnotations addObject:Annotation];
        }
        [mapView addAnnotations:arrAnnotations];
    }
}

-(void)callMarker{
    
    NSDictionary* dict1=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.549356",@"lat",@"77.26780099999999",@"lng",@"Mapmyindia Head Office New Delh,68,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict2=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.551844",@"lat",@"77.26749",@"lng",@"Juice Shop,261,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict3=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.554454",@"lat",@"77.265473",@"lng",@"Modi Mill Bus Stop,,Bhakti Vedant Swami Marg,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict4=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.549637999999998",@"lat",@"77.262909",@"lng",@"Dda Parking,Kalkaji Mandir Flyover U Turn,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSArray* arrCoordinate=[[NSArray alloc] initWithObjects:dict1,dict2,dict3,dict4, nil];
    
    [self addMarkers:arrCoordinate];
    
}
-(void)callMultipleMarkers{
    
    NSDictionary* dict1=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.549356",@"lat",@"77.26780099999999",@"lng",@"Mapmyindia Head Office New Delh,68,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict2=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.551844",@"lat",@"77.26749",@"lng",@"Juice Shop,261,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict3=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.554454",@"lat",@"77.265473",@"lng",@"Modi Mill Bus Stop,,Bhakti Vedant Swami Marg,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict4=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.549637999999998",@"lat",@"77.262909",@"lng",@"Dda Parking,Kalkaji Mandir Flyover U Turn,Okhla Industrial Estate Phase 3, New Delhi,Delhi",@"city", nil];
    NSDictionary* dict5=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.555245",@"lat",@"77.266117",@"lng",@"Modi Flour Mills",@"city", nil];
    NSDictionary* dict6=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.558149",@"lat",@"77.269787",@"lng",@"Taxi Stand",@"city", nil];
    NSDictionary* dict7=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.555369",@"lat",@"77.271042",@"lng",@"Basil",@"city", nil];
    NSDictionary* dict8=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.544428",@"lat",@"77.279057",@"lng",@"Harkesh Nagar Bus Stop",@"city", nil];
    NSDictionary* dict9=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.538275",@"lat",@"77.283821",@"lng",@"Jasola Apollo Metro Station",@"city", nil];
    NSDictionary* dict10=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.536604999999998",@"lat",@"77.2872",@"lng",@"Sarita Vihar Bus Stop",@"city", nil];
    NSDictionary* dict11=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.538442999999997",@"lat",@"77.291921",@"lng",@"Sarita Vihar Pocket K Bus Stop",@"city", nil];
    NSDictionary* dict12=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.542326",@"lat",@"77.30133",@"lng",@"Addidas",@"city", nil];
    NSDictionary* dict13=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.542609",@"lat",@"77.30211299999999",@"lng",@"Central Bank Of India",@"city", nil];
    NSDictionary* dict14=[[NSDictionary alloc] initWithObjectsAndKeys:@"28.543042999999997",@"lat",@"77.302843",@"lng",@"Shaheen Bagh Bus Stop",@"city", nil];
    
    NSArray* arrCoordinate=[[NSArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,dict9,dict10,dict11,dict12,dict13,dict14, nil];
    
    [self addMarkers:arrCoordinate];
    
}
-(void)drawPolyLine{
    
    NSString* pts= pts = @"}nomu@}}`krCe@mLuCtAuP`GqV`KgQi@e^vMyr@?kA~BqB~@qB?iD_CeiAtAe^tAoYi@uPwMeJkBwu@ph@x^~{@l\\ph@bWlN~tApb@l}@bWlRuAteAd]pV`OjUn\\QjJaFToEuCy^oZ_`@cQmqDafA{o@yWyGkDmHkFsSwQyGwMcCaGuyAurDeJaGeJuCoO?aFtA{NjHgqBnsA}KjF_V`EiNjJiNjJiD~BooBxrAiNjJmHtEm\\lToc@nZkA~@}b@xYcbArp@k_@bWobEdoCqiBbnAsrAj}@cCkDnYmRlf@o\\_Sec@aFkJ_IaOiDaGoOoXz[oVrFaExTd]`]e[hNxUpVwMbWpd@wv@nh@";
    NSMutableArray* decodedpolyArray=[self decodePolyLine:pts];
    
    decodedpolyArray=[[NSMutableArray alloc] initWithObjects:[[CLLocation alloc] initWithLatitude:28.54937553 longitude:77.26795197],[[CLLocation alloc] initWithLatitude:28.57071304 longitude:77.25985718], nil];
    mapView.polylineWidth=4.0;
    mapView.polylineColor=[UIColor blueColor];
    
    [mapView drawPolyLine:decodedpolyArray];
    [mapView zoomToFitAllLocationsAnimated:YES locations:decodedpolyArray];
}

-(void)drawPolygon
{
    NSMutableArray* polygonVertices = [[NSMutableArray alloc] initWithCapacity:50];
    CLLocation* location1=[[CLLocation alloc] initWithLatitude:26.613434 longitude:75.758556];
    CLLocation* location2=[[CLLocation alloc] initWithLatitude:26.311922 longitude:76.492635];
    CLLocation* location3=[[CLLocation alloc] initWithLatitude:26.230916 longitude:76.130366];
    CLLocation* location4=[[CLLocation alloc] initWithLatitude:26.364601 longitude:75.832132];
    CLLocation* location5=[[CLLocation alloc] initWithLatitude:26.613434 longitude:75.758556];
    
    [polygonVertices addObject:location1];
    [polygonVertices addObject:location2];
    [polygonVertices addObject:location3];
    [polygonVertices addObject:location4];
    [polygonVertices addObject:location5];
    [mapView drawPolyLine:polygonVertices];
    [mapView zoomToFitAllLocationsAnimated:YES locations:polygonVertices];
}

-(void)drawCircle
{
    MMIAnnotation* annotation=[[MMIAnnotation alloc] init];
    annotation.latitude=28.526;
    annotation.longitude=78.568;
    annotation.radiusInMeters=500;
    annotation.lineWidthInPixels=5;
      mapView.isAddOverlay=YES;
    
   
   // annotation.lineColor=[UIColor redColor];
  //  annotation.fillColor=[UIColor colorWithRed:.5 green:.466 blue:.733 alpha:.25];
}

#pragma mark - Polyline decode Method
-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr {
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-6];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-6];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    
    return array;
}


-(void)reverseGeocode:(float)startPoint point:(float)finalPoint
{
    MapmyIndiaReverseGeocodeManager * reverseGeocodeManager = [MapmyIndiaReverseGeocodeManager sharedManager];
    MapmyIndiaReverseGeocodeOptions *revOptions =[[MapmyIndiaReverseGeocodeOptions alloc] initWithCoordinate:CLLocationCoordinate2DMake(startPoint, finalPoint) withRegion:MMIRegionTypeIdentifierDefault];
    [reverseGeocodeManager reverseGeocodeWithOptions:revOptions completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"NSlog");
            return;
        }
        MapmyIndiaGeocodedPlacemark * dict = [placemarks objectAtIndex:0];
        lblRevreseGeoCodeResult.text = [NSString stringWithFormat:@"%@",dict.formattedAddress];
    }];
    
}

#pragma mark - MMIDelegate


- (void)singleTapOnMap:(MMIMapView *)map at:(CGPoint)point{
    
    NSLog(@"latitude >>> %f, Longitude >>>>   %f",[mapView pixelToCoordinateAt:point].latitude,[mapView pixelToCoordinateAt:point].longitude);
    float startPoint=[mapView pixelToCoordinateAt:point].latitude;
    float endPoint=[mapView pixelToCoordinateAt:point].longitude;
    
    if(checkForGeocode==YES){
        //[self reverseGeocode:startPoint point:endPoint];
    }
    
}
- (void)tapOnAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map{
    
    NSLog(@"%@",annotation.title);
    
}
- (void)afterMapMove:(MMIMapView *)map byUser:(BOOL)wasUserAction{
    
    lblMapCenter.text=[NSString stringWithFormat:@"%f,%f",map.centerCoordinate.latitude,map.centerCoordinate.longitude];
    lblTopLeft.text=[NSString stringWithFormat:@"%f,%f",map.NECoordinate.latitude,map.NECoordinate.longitude];
    lblTopRight.text=[NSString stringWithFormat:@"%f,%f",map.NECoordinate.latitude,map.SWCoordinate.longitude];
    lblBottomLeft.text=[NSString stringWithFormat:@"%f,%f",map.SWCoordinate.latitude,map.NECoordinate.longitude];
    lblBottomRight.text=[NSString stringWithFormat:@"%f,%f",map.SWCoordinate.latitude,map.SWCoordinate.longitude];
    lblZoomLevel.text=[NSString stringWithFormat:@"%0.f",map.zoom];
}

-(void)directionManager
{
    MapmyIndiaRouteTripManager *routeTripManager = [MapmyIndiaRouteTripManager sharedManager];
    CLLocation *sourceLocation = [[CLLocation alloc] initWithLatitude:[txtStartDirection1.text floatValue] longitude:[txtStartDirection2.text floatValue]];
    CLLocation *destinationLocation = [[CLLocation alloc] initWithLatitude:[txtDestination1.text floatValue] longitude:[txtDestination2.text floatValue]];
    
    MapmyIndiaRouteTripOptions *routeOptions = [[MapmyIndiaRouteTripOptions alloc] initWithStartLocation:sourceLocation destinationLocation:destinationLocation];
    
    [routeOptions setRouteType:MMIDistanceRouteTypeQuickest];
    [routeOptions setVehicleType:MMIDistanceVehicleTypePassenger];
    [routeOptions setAvoids:MMIDistanceAvoidsTypeAvoidToll];
    [routeOptions setWithAdvices:true];
    [routeOptions setWithAlternatives:false];
    [routeTripManager getResultWithOptions:routeOptions completionHandler:^(MapmyIndiaTripResult * _Nullable result, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        if(result){
            
            NSArray* arrMainRoute=result.trips ;
            for(int i=0;i<arrMainRoute.count;i++){
                MapmyIndiaTrip* dictRoute=[arrMainRoute objectAtIndex:i];
                mapView.polylineWidth=4.0;
                mapView.polylineColor=[UIColor greenColor];
                [mapView drawPolyLine:dictRoute.locations];
                [mapView zoomToFitAllLocationsAnimated:YES locations:dictRoute.locations];
            }
        } else {
            NSLog(@"No results");
        }
        ViewDirections.hidden=YES;
    }];
}

-(void)getDistance
{
    MapmyIndiaDrivingDistanceManager * distanceManager = [MapmyIndiaDrivingDistanceManager sharedManager];
    MapmyIndiaDrivingDistanceOptions *distanceOptions = [[MapmyIndiaDrivingDistanceOptions alloc] initWithCenter:[[CLLocation alloc] initWithLatitude:[txtCenterLat.text floatValue] longitude:[txtCenterLong.text floatValue]] points:[NSArray arrayWithObjects: [[CLLocation alloc] initWithLatitude:[txtOtherPoint1.text floatValue] longitude:[txtOtherPoint2.text floatValue]], nil]];
    
    [distanceManager getResultWithOptions:distanceOptions completionHandler:^(NSArray<MapmyIndiaDrivingDistancePlacemark *> * _Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        if(placemarks){
            MapmyIndiaDrivingDistancePlacemark* dictTemp= [placemarks objectAtIndex:0];
            lblDistanceTime.text=[NSString stringWithFormat:@"Time:%@ secs Distance:%@ mts",dictTemp.duration, dictTemp.length];
        }
    }];
}


- (IBAction)btnDistance:(id)sender {
    [self getDistance];
    
}
- (IBAction)btnReverseGeoCodeAction:(id)sender {
    
    
    float startPoint=[txtReverseGeocode1.text floatValue];
    float endPoint=[txtReverseGeocode2.text floatValue];
    
     [self reverseGeocode:startPoint point:endPoint];

    
}

- (IBAction)takeScreenshot:(id)sender {
    
    UIImage *image= mapView.takeMapViewScreenshot;
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}



#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==tblViewAutoSearch){
        return arrAutoSearch.count;
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"] ;
    }
    if(tableView==tblViewAutoSearch){
        MapmyIndiaAtlasSuggestion* dict=[arrAutoSearch objectAtIndex:indexPath.row];
        cell.textLabel.text=dict.placeName;
        cell.detailTextLabel.text=dict.placeAddress;
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
