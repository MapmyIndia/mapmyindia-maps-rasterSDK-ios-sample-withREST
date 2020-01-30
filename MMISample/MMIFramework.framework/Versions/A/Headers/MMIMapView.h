//
//  MMIMapView.h
//  MMIFramework
//
//  Created by mac on 14/04/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMIAnnotation.h"
#import <CoreLocation/CoreLocation.h>

// MapView
@class MMIMapView;
@protocol MMIDelegate <NSObject>
@optional

/** Tells the delegate that the visible layer for an annotation is about to be hidden from view due to scrolling or zooming the map.
 *   @param mapView The map view whose annotation alyer will be hidden.
 *   @param annotation The annotation whose layer will be hidden. */
- (void)mapView:(MMIMapView *)mapView willHideLayerForAnnotation:(MMIAnnotation *)annotation;

/** Tells the delegate that the visible layer for an annotation has been hidden from view due to scrolling or zooming the map.
 *   @param mapView The map view whose annotation layer was hidden.
 *   @param annotation The annotation whose layer was hidden. */
- (void)mapView:(MMIMapView *)mapView didHideLayerForAnnotation:(MMIAnnotation *)annotation;

/** Tells the delegate that one of its annotations was selected.
 *
 *   You can use this method to track changes in the selection state of annotations.
 *   @param mapView The map view containing the annotation.
 *   @param annotation The annotation that was selected. */
- (void)mapView:(MMIMapView *)mapView didSelectAnnotation:(MMIAnnotation *)annotation;

/** Tells the delegate that one of its annotations was deselected.
 *
 *   You can use this method to track changes in the selection state of annotations.
 *   @param mapView The map view containing the annotation.
 *   @param annotation The annotation that was deselected. */
- (void)mapView:(MMIMapView *)mapView didDeselectAnnotation:(MMIAnnotation *)annotation;

/** @name Responding to Map Position Changes */

/** Tells the delegate when a map has finished moving.
 *   @param map The map view that has finished moving.
 *   @param wasUserAction A Boolean indicating whether the map move was in response to a user action or not. */
- (void)afterMapMove:(MMIMapView *)map byUser:(BOOL)wasUserAction;

/** Tells the delegate when a map is about to zoom.
 *   @param map The map view that is about to zoom.
 *   @param wasUserAction A Boolean indicating whether the map zoom is in response to a user action or not. */
- (void)beforeMapZoom:(MMIMapView *)map byUser:(BOOL)wasUserAction;

/** Tells the delegate when a map has finished zooming.
 *   @param map The map view that has finished zooming.
 *   @param wasUserAction A Boolean indicating whether the map zoom was in response to a user action or not. */
- (void)afterMapZoom:(MMIMapView *)map byUser:(BOOL)wasUserAction;

/** Tells the delegate that the region displayed by the map view just changed.
 *
 *   This method is called whenever the currently displayed map region changes. During scrolling, this method may be called many times to report updates to the map position. Therefore, your implementation of this method should be as lightweight as possible to avoid affecting scrolling performance.
 *   @param mapView The map view whose visible region changed. */
- (void)mapViewRegionDidChange:(MMIMapView *)mapView;

/** @name Responding to Map Gestures */

/** Tells the delegate when the user double-taps a map view.
 *   @param map The map that was double-tapped.
 *   @param point The point at which the map was double-tapped. */
- (void)doubleTapOnMap:(MMIMapView *)map at:(CGPoint)point;

/** Tells the delegate when the user taps a map view.
 *   @param map The map that was tapped.
 *   @param point The point at which the map was tapped. */
- (void)singleTapOnMap:(MMIMapView *)map at:(CGPoint)point;

/** Tells the delegate when the user taps a map view with two fingers.
 *   @param map The map that was tapped.
 *   @param point The center point at which the map was tapped. */
- (void)singleTapTwoFingersOnMap:(MMIMapView *)map at:(CGPoint)point;

/** Tells the delegate when the user long-presses a map view.
 *   @param map The map that was long-pressed.
 *   @param point The point at which the map was long-pressed. */
- (void)longPressOnMap:(MMIMapView *)map at:(CGPoint)point;

/** @name Responding to User Annotation Gestures */

/** Tells the delegate when the user taps the layer for an annotation.
 *   @param annotation The annotation that was tapped.
 *   @param map The map view. */
- (void)tapOnAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map;

/** Tells the delegate when the user double-taps the layer for an annotation.
 *   @param annotation The annotation that was double-tapped.
 *   @param map The map view. */
- (void)doubleTapOnAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map;

/** Tells the delegate when the user long-presses the layer for an annotation.
 *   @param annotation The annotation that was long-pressed.
 *   @param map The map view. */
- (void)longPressOnAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map;

/** Tells the delegate when the user taps the label for an annotation.
 *   @param annotation The annotation whose label was was tapped.
 *   @param map The map view. */
- (void)tapOnLabelForAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map;

/** Tells the delegate when the user double-taps the label for an annotation.
 *   @param annotation The annotation whose label was was double-tapped.
 *   @param map The map view. */
- (void)doubleTapOnLabelForAnnotation:(MMIAnnotation *)annotation onMap:(MMIMapView *)map;



-(void)tapOnCalloutAccessoryControl:(MMIAnnotation*)annotaion onMap:(MMIMapView*)map;


@end
@interface MMIMapView : UIView

@property(nonatomic, assign)BOOL showUserLocation;
@property(nonatomic, assign)CLLocationCoordinate2D userLocation;
@property(nonatomic, assign)CLLocationCoordinate2D tempLocation;
@property(nonatomic, assign)BOOL clusteringEnabled;
@property(nonatomic, assign)BOOL isAddOverlay;
@property(nonatomic, assign)float polylineWidth;
@property(nonatomic, strong)UIColor* polylineColor;
@property(nonatomic, assign)IBOutlet id<MMIDelegate> delegate;
@property(nonatomic, assign)CLLocationCoordinate2D centerCoordinate;
@property(nonatomic, assign)float zoom;
@property(nonatomic, assign)CLLocationCoordinate2D SWCoordinate;
@property(nonatomic, assign)CLLocationCoordinate2D NECoordinate;
-(void)addMapView;
-(void)addAnnotation:(MMIAnnotation*)annotation;
-(void)addAnnotations:(NSArray*)array;
-(void)removeAnnotation:(MMIAnnotation*)annotation;
-(void)removeAllAnnotations;
-(void)drawPolyLine:(NSArray*)locations;
-(void)drawPolyLine:(NSArray*)locations andLineColor:(UIColor*)color;
-(void)removePolyLine;
-(CLLocationCoordinate2D)pixelToCoordinateAt:(CGPoint)point;
-(void)showRoute:(NSDictionary*)result;
-(void)openMapAPP;
-(void)zoomToFitAllAnnotationsAnimated:(BOOL)animated locations:(NSArray *)annotations;
-(void)zoomToFitAllLocationsAnimated:(BOOL)animated locations:(NSArray *)locations;
-(void)zoomToFitAllAnnotationsAnimated:(BOOL)animated annotations:(NSArray *)annotations;
-(void)zoomWithLatitudeLongitudeBoundsSouthWest:(CLLocationCoordinate2D)southWest northEast:(CLLocationCoordinate2D)northEast animated:(BOOL)animated;
-(void)zoomWithLatitudeLongitudeRadius:(CLLocationCoordinate2D)coordinate radiusInMeters:(double)meters animated:(BOOL)animated;
-(CLLocationDistance)zoomRadiusOfMap;
-(CLLocationDistance)distanceBetweenCoordinate:(CLLocationCoordinate2D)originCoordinate andCoordinate:(CLLocationCoordinate2D)destinationCoordinate;
-(CLLocationCoordinate2D)midpointBetweenCoordinate:(CLLocationCoordinate2D)coordinate1 andCoordinate:(CLLocationCoordinate2D)coordinate2;
-(void)selectAnnotation:(MMIAnnotation *)annotation;
-(UIImage *)takeMapViewScreenshot;
-(UIButton *)getZoomInButton;
-(UIButton *)getZoomOutButton;
-(UIButton *)getCurrentLocationButton;
-(void)showCurrentLocationButton:(BOOL) show;
-(void)showZoomButtons:(BOOL) show;
-(UIView *)getZoomButtonsContainer;

@end
