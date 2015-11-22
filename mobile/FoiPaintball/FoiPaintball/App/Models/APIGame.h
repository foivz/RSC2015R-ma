//
//  APIGame.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "APILocation.h"

@interface APIGame : JSONModel

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger gameId;
@property (assign, nonatomic) NSInteger field_id;
@property (strong, nonatomic) NSString *type;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger duration;
@property (strong, nonatomic) APILocation *team_a;
@property (strong, nonatomic) APILocation *team_b;
@property (strong, nonatomic) NSArray<APILocation> *obstacles;
@property (strong, nonatomic) NSString<Optional> *pin;
@property (assign, nonatomic) BOOL playing;
@end
