//
//  APILoginResult.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "APIUser.h"

@interface APILoginResult : JSONModel
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) APIUser *user;
@end
