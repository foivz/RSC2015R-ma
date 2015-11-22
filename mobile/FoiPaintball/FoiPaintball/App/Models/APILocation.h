//
//  APILocation.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>
#import "APIPlayer.h"

@protocol APILocation <NSObject>
@end

@interface APILocation : JSONModel
@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;
@property (strong, nonatomic) NSString<Optional> *type; //flag, obstacle
@property (strong, nonatomic) NSArray<APIPlayer> *players;
@end
