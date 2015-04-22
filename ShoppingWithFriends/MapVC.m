//
//  MapVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/22/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "MapVC.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapVC ()

@property IBOutlet GMSMapView *map;

@end

@implementation MapVC {
    
    //GMSMapView *mapView_;
    
}

- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    self.map.camera = camera;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = self.map;
}

@end
