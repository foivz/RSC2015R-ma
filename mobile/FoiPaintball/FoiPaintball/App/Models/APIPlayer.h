//
//  APIPlayer.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 21/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol APIPlayer <NSObject>
@end

@interface APIPlayer : JSONModel
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL ready;
@end
