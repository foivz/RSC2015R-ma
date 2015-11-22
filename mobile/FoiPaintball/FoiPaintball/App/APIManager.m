//
//  APIManager.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "APIManager.h"
#import <CoreLocation/CoreLocation.h>

@interface APIManager()
@property (readonly, strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) APIGame *lastCreatedGame;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation APIManager

+ (instancetype)sharedInstance
{
    static APIManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseUrl = @"http://37.139.4.107:3000/api/";
        sharedMyManager = [[self alloc] init];
        sharedMyManager.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        sharedMyManager.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        sharedMyManager.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        sharedMyManager.locationManager = [CLLocationManager new];
        sharedMyManager.locationManager.distanceFilter = kCLDistanceFilterNone;
        sharedMyManager.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [sharedMyManager.locationManager requestWhenInUseAuthorization];
        [sharedMyManager.locationManager startUpdatingLocation];
        
        [sharedMyManager postLocation];
        
    });
    return sharedMyManager;
}

- (void)registerWithAPIregister:(APIRegister *)apiRegister withSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = @"users";
    
    APIUserRegister *userRegister = [APIUserRegister new];
    userRegister.user = apiRegister;
    
    [self.manager POST:url parameters:[userRegister toDictionary]  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(YES);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)logInWithAPILogin:(APILogin *)apiLogin withSuccess:(void (^)(APILoginResult *))success failure:(void (^)(NSString *))failure
{
    NSString *url = @"authentication/login";
    
    [self.manager POST:url parameters:[apiLogin toDictionary]  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSError *error;
        APILoginResult *apiLoginResult = [[APILoginResult alloc] initWithDictionary:[responseObject objectForKey:@"login"] error:&error];
        
        [self.manager.requestSerializer setValue:apiLoginResult.accessToken forHTTPHeaderField:@"X-AccessToken"];
        [self.manager.requestSerializer setValue:apiLoginResult.user.userID forHTTPHeaderField:@"X-AccessId"];
        
        self.user = apiLoginResult.user;
        success(apiLoginResult);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(@"Log in failed");
        
    }];
}

- (void)logInWithPinCode:(NSString *)pinCode withSuccess:(void (^)(APILoginResult *))success failure:(void (^)(NSString *))failure
{
    NSString *url = @"authentication/login";
    
    APILogin *apiLogin = [APILogin new];
    apiLogin.password = pinCode;
    apiLogin.username = [self getUniqueDeviceIdentifierAsString];
    
    [self.manager POST:url parameters:[apiLogin toDictionary]  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        APILoginResult *apiLoginResult = [[APILoginResult alloc] initWithDictionary:[responseObject objectForKey:@"login"] error:nil];
        
        [self.manager.requestSerializer setValue:apiLoginResult.accessToken forHTTPHeaderField:@"X-AccessToken"];
        [self.manager.requestSerializer setValue:apiLoginResult.user.userID forHTTPHeaderField:@"X-AccessId"];
        
        self.user = apiLoginResult.user;
        success(apiLoginResult);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        failure(@"Log in failed");
        
    }];
}

- (void)fieldsWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure
{
    NSString *url = @"fields?occupied=false";
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSArray *fields = [APIField arrayOfModelsFromDictionaries:[responseObject objectForKey:@"fields"]];
        success(fields);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(@"error ");
    }];
    
}

- (void)createGameWithGame:(APIGame *)apiGame success:(void (^)(APIGame *))success failure:(void (^)(BOOL))failure
{
    NSString *url = @"games";
    
    [self.manager POST:url parameters:[apiGame toDictionary] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        self.lastCreatedGame = apiGame;
        
        NSError *jsonError;
        APIGame *game = [[APIGame alloc] initWithDictionary:[responseObject objectForKey:@"game"] error:&jsonError];
        
        self.currentGame = game;
        
        success(game);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)playersAreReadyInWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = [NSString stringWithFormat:@"games/%ld/ready", (long)self.currentGame.gameId];
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(YES);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)startGameWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = [NSString stringWithFormat:@"games/%ld/start", (long)self.currentGame.gameId];
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        success(YES);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)refreshGameWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = [NSString stringWithFormat:@"games/%ld", (long)self.currentGame.gameId];
    
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError *jsonError;
        APIGame *game = [[APIGame alloc] initWithDictionary:[responseObject objectForKey:@"game"] error:&jsonError];
        
        self.currentGame = game;
        
        success(game);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)joinGameWithAPIJoinGame:(APIJoinGame *)joinGame success:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = @"games/join";
    
    self.myTeam = joinGame.team;
    
    [self.manager POST:url parameters:[joinGame toDictionary] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        NSError *jsonError;
        APIGame *game = [[APIGame alloc] initWithDictionary:[responseObject objectForKey:@"game"] error:&jsonError];
        
        self.currentGame = game;
        
        success(YES);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)playerIsReadyWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure
{
    NSString *url = [NSString stringWithFormat:@"users/%@/ready", self.user.userID];
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        
        success(YES);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        failure(NO);
    }];
}

- (void)postLocation
{

    NSString *url = [NSString stringWithFormat:@"users/%@/location", self.user.userID];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    APILocation *myLocation = [APILocation new];
    myLocation.longitude = self.locationManager.location.coordinate.longitude;
    myLocation.latitude = self.locationManager.location.coordinate.latitude;
    
    
    [self.manager POST:url parameters:[myLocation toDictionary] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self postLocation];
        });
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self postLocation];
        });
    }];
}



-(NSString *)getUniqueDeviceIdentifierAsString
{

    NSString *strApplicationUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"incoding"];
    if (strApplicationUUID == nil)
    {
        strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:strApplicationUUID forKey:@"incoding"];
    }
    
    return [strApplicationUUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (void)attack
{
    NSString *url = @"team_messages/attack";
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
 
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];
}

- (void)fallback
{
    NSString *url = @"team_messages/fallback";
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];

}

- (void)cover
{
    NSString *url = @"team_messages/cover";
    
    [self.manager POST:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
    }];

}

@end
