//
//  APIField.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

@interface APIField : JSONModel
@property (assign, nonatomic) NSInteger field_id;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CGFloat latitude_nw;
@property (assign, nonatomic) CGFloat longitude_nw;
@property (assign, nonatomic) CGFloat latitude_se;
@property (assign, nonatomic) CGFloat longitude_se;
@property (assign, nonatomic) BOOL occupied;

- (CGFloat)centerLongitude;
- (CGFloat)centerLatitude;

@end
