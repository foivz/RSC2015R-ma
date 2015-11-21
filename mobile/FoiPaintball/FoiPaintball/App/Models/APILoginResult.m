//
//  APILoginResult.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "APILoginResult.h"

@implementation APILoginResult
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"access_token":@"accessToken"
                                                       }];
}
@end
