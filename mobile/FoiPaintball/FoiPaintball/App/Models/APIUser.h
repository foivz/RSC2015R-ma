//
//  APIUser.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "APIUser.h"
#import "APIPlayer.h"

@interface APIUser : JSONModel

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *role;
@property (assign, nonatomic) BOOL active;
@property (strong, nonatomic) NSArray<APIPlayer> *players;
@end
