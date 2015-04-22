//
//  MapVC.m
//  ShoppingWithFriends
//
//  Created by Jay Reynolds on 4/22/15.
//  Copyright (c) 2015 com.reynoldsJay. All rights reserved.
//

#import "MapVC.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

@interface MapVC ()

@property IBOutlet GMSMapView *map;

@end

@implementation MapVC {
    
    //GMSMapView *mapView_;
    
}

- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:[self geoCodeUsingAddress:@"Georgia Tech"]zoom:10];
    self.map.camera = camera;
    
    PFQuery *query = [PFQuery queryWithClassName:@"SalesReport"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *match in objects) {
                CLLocationCoordinate2D address = [self geoCodeUsingAddress:match[@"location"]];
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = address;
                marker.title = match[@"name"];
                marker.snippet = [NSString stringWithFormat:@"$%d", [match[@"price"] integerValue]];
                marker.map = self.map;
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    // Creates a marker in the center of the map.

}

- (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
}

@end
