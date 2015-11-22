//
//  MapCreateViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "MapCreateViewController.h"
#import <MapKit/MapKit.h>
#import "MyLocation.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIManager.h"


#define METERS_PER_MILE 1609.344

@interface MapCreateViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIImageView *centerImage;

@property (strong, nonatomic) NSMutableArray *pois;

@end

@implementation MapCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pois = [NSMutableArray new];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.field.centerLatitude;
    zoomLocation.longitude= self.field.centerLongitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapView.showsUserLocation = YES;
}


- (IBAction)valueChangedOnSegemnt:(UISegmentedControl *)sender {
    UIImage *image = nil;
    if (sender.selectedSegmentIndex == 0) {
        if (self.game.team_a && self.game.team_b) {

        } else if (self.game.team_a == nil) {
            image = [UIImage imageNamed:@"pin_flag_a"];
            
        } else {
            image = [UIImage imageNamed:@"pin_flag_b"];
        }
        
    } else if (sender.selectedSegmentIndex == 1) {
        image = [UIImage imageNamed:@"pin_flag"];
    } else {
        image = [UIImage imageNamed:@"pin_obstacle"];
    }
    
    self.centerImage.image = image;
}

#pragma mark - mapview

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MyLocation *myLocation = annotation;
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = myLocation.image;
        } else {
            annotationView.annotation = annotation;
        }
        
    
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
   // [self.mapView addAnnotation:point];
}

- (IBAction)addPoiButton:(UIButton *)sender {
    CLLocationCoordinate2D centerLocation = [self.mapView region].center;
    APILocation *apiLocation = [APILocation new];
    apiLocation.latitude = centerLocation.latitude;
    apiLocation.longitude = centerLocation.longitude;
    
    MyLocation *location = nil;
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        if (self.game.team_a && self.game.team_b) {
            return;
        } else if (self.game.team_a == nil) {
            location = [[MyLocation alloc] initWithName:@"Team A" address:@"start point" coordinate:centerLocation];
            location.image = self.centerImage.image;
            
            self.game.team_a = apiLocation;
            
        } else {
            location = [[MyLocation alloc] initWithName:@"Team A" address:@"start point" coordinate:centerLocation];
            location.image = self.centerImage.image;
            
            self.game.team_b = apiLocation;
        }
        
        
    }

    
    if (self.segmentControl.selectedSegmentIndex == 1) {
        location = [[MyLocation alloc] initWithName:@"Flag" address:@"" coordinate:centerLocation];
        apiLocation.type = @"flag";
        [self.pois addObject:apiLocation];
    } else if (self.segmentControl.selectedSegmentIndex == 2) {
        location = [[MyLocation alloc] initWithName:@"Obstacle" address:@"" coordinate:centerLocation];
        apiLocation.type = @"obstacle";
        
        [self.pois addObject:apiLocation];
    }
    
    
    
    location.image = self.centerImage.image;
    
    [self.mapView addAnnotation:location];
    
    
    [UIView animateWithDuration:0.15 animations:^{
        self.centerImage.transform = CGAffineTransformMakeScale(1.4, 1.4);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.centerImage.transform = CGAffineTransformIdentity;
        }];
    }];
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        UIImage *image = nil;
        if (self.game.team_a && self.game.team_b) {
            
        } else if (self.game.team_a == nil) {
            image = [UIImage imageNamed:@"pin_flag_a"];
            
        } else {
            image = [UIImage imageNamed:@"pin_flag_b"];
        }
        self.centerImage.image = image;
    }
}

- (IBAction)nextButtonClicked:(UIBarButtonItem *)sender {
    
    self.game.obstacles = (NSArray<APILocation> *)self.pois;
    
    [SVProgressHUD showWithStatus:@"CreatingGame"];
    [[APIManager sharedInstance] createGameWithGame:self.game success:^(APIGame *game) {
        
        [SVProgressHUD showSuccessWithStatus:@"Game created"];
        
        [self performSegueWithIdentifier:@"GameReadyViewController" sender:nil];
        
    } failure:^(BOOL b) {
        [SVProgressHUD showErrorWithStatus:@"Failed to create"];
    }];
}


@end
