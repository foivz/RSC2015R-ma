//
//  APIManager.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#import "APILogin.h"
#import "APIRegister.h"
#import "APIUser.h"
#import "APILoginResult.h"
#import "APIUserRegister.h"
#import "APIField.h"
#import "APIGame.h"
#import "APIJoinGame.h"
#import "APIMessage.h"
#import "APIPostMessage.h"

@interface APIManager : NSObject
@property (strong, nonatomic) APIUser *user;
+ (instancetype)sharedInstance;

@property (strong, nonatomic) APIGame *currentGame;
@property (strong, nonatomic) NSString *myTeam;

@property (strong, nonatomic) NSArray *teamAMessages;
@property (strong, nonatomic) NSArray *teamBMessages;

- (void)registerWithAPIregister:(APIRegister *)apiRegister withSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)logInWithAPILogin:(APILogin *)apiLogin withSuccess:(void (^)(APILoginResult *))success failure:(void (^)(NSString *))failure;
- (void)logInWithPinCode:(NSString *)pinCode withSuccess:(void (^)(APILoginResult *))success failure:(void (^)(NSString *))failure;

- (void)fieldsWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure;
- (void)createGameWithGame:(APIGame *)apiGame success:(void (^)(APIGame *))success failure:(void (^)(BOOL))failure;

- (void)playersAreReadyInWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)startGameWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)refreshGameWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;
- (void)joinGameWithAPIJoinGame:(APIJoinGame *)joinGame success:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)playerIsReadyWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;
- (void)postLocation;

- (void)attack;
- (void)fallback;
- (void)cover;

- (void)killWithUserId:(NSString *)userId withSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)getTeamAMessagesWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;
- (void)getTeamBMessagesWithSuccess:(void (^)(BOOL))success failure:(void (^)(BOOL))failure;

- (void)sendMessageLikeA:(NSString *)message;
- (void)sendMessageLikeB:(NSString *)message;

@end
