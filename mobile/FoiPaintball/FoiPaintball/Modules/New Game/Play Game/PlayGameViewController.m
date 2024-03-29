//
//  PlayGameViewController.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "PlayGameViewController.h"
#import <MapKit/MapKit.h>
#import "MyLocation.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "APIManager.h"

#define kMETERS_PER_MILE 1609.344

@interface PlayGameViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) APIManager *apiManager;
@property (strong, nonatomic) NSMutableArray *teamAPois;
@property (strong, nonatomic) NSMutableArray *teamBPois;

@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *seconfButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;
@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@end

@implementation PlayGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.apiManager = [APIManager sharedInstance];
    
    if ([self.apiManager.user.role isEqualToString:@"judge"]) {
        
        self.firstButton.hidden = YES;
        self.seconfButton.hidden = YES;
        self.thirdButton.hidden = YES;
        self.fourButton.hidden = YES;
        
    }
    
    self.popView.alpha = 0;
    
    NSString *gameType = self.apiManager.currentGame.type;
    if (![gameType isEqualToString:@"ctf"] || [self.apiManager.user.role isEqualToString:@"judge"]) {
        self.rightBarButton.enabled = NO;
    }
    
    
    CLLocationCoordinate2D cordinateA = CLLocationCoordinate2DMake(self.apiManager.currentGame.team_a.latitude, self.apiManager.currentGame.team_a.longitude);
    
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(cordinateA, 0.3*kMETERS_PER_MILE, 0.3*kMETERS_PER_MILE);
    
    // 3
    [_mapView setRegion:viewRegion animated:YES];
    
    MyLocation *teamALocation = [[MyLocation alloc] initWithName:@"Team A" address:@"" coordinate:cordinateA];
    teamALocation.image = [UIImage imageNamed:@"pin_flag_a"];
    
    [self.mapView addAnnotation:teamALocation];
    
    
    CLLocationCoordinate2D cordinateB = CLLocationCoordinate2DMake(self.apiManager.currentGame.team_b.latitude, self.apiManager.currentGame.team_b.longitude);
    MyLocation *teamBLocation = [[MyLocation alloc] initWithName:@"Team B" address:@"" coordinate:cordinateB];
    teamBLocation.image = [UIImage imageNamed:@"pin_flag_b"];
    
    [self.mapView addAnnotation:teamBLocation];
    
    for (APILocation *poi in self.apiManager.currentGame.obstacles) {
        CLLocationCoordinate2D cordinatePoi = CLLocationCoordinate2DMake(poi.latitude, poi.longitude);
        MyLocation *poiLocation = [[MyLocation alloc] initWithName:poi.type address:@"" coordinate:cordinatePoi];
        
        poiLocation.image = [poi.type isEqualToString:@"flag"] ? [UIImage imageNamed:@"pin_flag"] : [UIImage imageNamed:@"pin_obstacle"];
        
        [self.mapView addAnnotation:poiLocation];
        
    }
    
    [self refreshGame];
}

- (void)refreshGame
{
    [[APIManager sharedInstance] refreshGameWithSuccess:^(BOOL b) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![APIManager sharedInstance].currentGame.playing) {
                NSString *wonString = [NSString stringWithFormat:@"Team %@ is victourious",[APIManager sharedInstance].currentGame.won];
                
                
                self.winLabel.text = wonString;
                
                
                self.popView.transform = CGAffineTransformMakeTranslation(0, self.popView.frame.size.height);
                [UIView animateWithDuration:0.5 animations:^{
                    
                    self.popView.transform = CGAffineTransformIdentity;
                    self.popView.alpha = 1;
                    
                }];
            } else
            {
                
                [self reloadPois];
                [self refreshGame];
            }
           
        });
        
    } failure:^(BOOL b) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self refreshGame];
        });
    }];
}

- (void)reloadPois
{
    if (self.teamAPois) {
        [self.mapView removeAnnotations: self.teamAPois];
    }
    
    if (self.teamBPois) {
        [self.mapView removeAnnotations:self.teamBPois];
    }
    
    if (self.apiManager.myTeam == nil || [self.apiManager.myTeam isEqualToString:@"a"]) {
        self.teamAPois = [NSMutableArray new];
        
        for (APIPlayer *player in self.apiManager.currentGame.team_a.players) {
            CLLocationCoordinate2D cordinate = CLLocationCoordinate2DMake(player.latitude, player.longitude);
            MyLocation *location = [[MyLocation alloc] initWithName:player.name address:@"" coordinate:cordinate];
            
            if ([player.playerId isEqualToString:self.apiManager.user.userID]) {
                location.image = [UIImage imageNamed:@"pin_mine"];
            } else {
                location.image = [UIImage imageNamed:@"pin_Aplayer"];
            }
            
            [self.teamAPois addObject:location];
        }
    }
    
    
    if (self.apiManager.myTeam == nil || [self.apiManager.myTeam isEqualToString:@"b"]) {
        self.teamBPois = [NSMutableArray new];
        
        for (APIPlayer *player in self.apiManager.currentGame.team_b.players) {
            CLLocationCoordinate2D cordinate = CLLocationCoordinate2DMake(player.latitude, player.longitude);
            MyLocation *location = [[MyLocation alloc] initWithName:player.name address:@"" coordinate:cordinate];
            
            if ([player.playerId isEqualToString:self.apiManager.user.userID]) {
                location.image = [UIImage imageNamed:@"pin_mine"];
            } else {
                location.image = [UIImage imageNamed:@"pin_Bplayer"];
            }
            [self.teamBPois addObject:location];

        }
    }
    
    if (self.teamAPois) {
        [self.mapView addAnnotations:self.teamAPois];
    }
    
    if (self.teamBPois) {
        [self.mapView addAnnotations:self.teamBPois];
    }
    
}

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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *pinCode = [alertView textFieldAtIndex:0].text;
        NSLog(@"%@",[[alertView textFieldAtIndex:0] text]);
        
        
        [SVProgressHUD showWithStatus:@"Taking the flag!"];
        [[APIManager sharedInstance] captureWithPin:pinCode withSuccess:^(BOOL b) {
            
            [SVProgressHUD showSuccessWithStatus:@"Flag taken"];
            
        } failure:^(BOOL b) {
            [SVProgressHUD showErrorWithStatus:@"Failed to take a flag"];
        }];

    }
}

- (IBAction)clickedRightBarButton:(UIBarButtonItem *)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Enter flag code:"  message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok",nil];
    
    
    
    [alertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    UITextField* tf = [alertView textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    [alertView show];
    
}


- (IBAction)deadButton:(UIButton *)sender {
    
    [self.apiManager killWithUserId:self.apiManager.user.userID withSuccess:^(BOOL a) {
        
    } failure:^(BOOL a) {
        
    }];
    
}

- (IBAction)forwardbutton:(UIButton *)sender {
    [self.apiManager attack];
}

- (IBAction)backButton:(UIButton *)sender {
    [self.apiManager fallback];
}

- (IBAction)needHelp:(UIButton *)sender {
    [self.apiManager cover];
}


@end
