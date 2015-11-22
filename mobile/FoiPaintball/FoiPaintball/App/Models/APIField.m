//
//  APIField.m
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import "APIField.h"

@implementation APIField

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"field_id"
                                                       }];
}

- (CGFloat)centerLatitude
{
    return (self.latitude_nw + self.latitude_se)/2;
}

- (CGFloat)centerLongitude
{
    return (self.longitude_nw + self.longitude_se)/2;
}


@end
