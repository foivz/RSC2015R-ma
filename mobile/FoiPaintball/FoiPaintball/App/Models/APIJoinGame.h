//
//  APIJoinGame.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APIJoinGame : JSONModel
@property (strong, nonatomic) NSString *pin;
@property (strong, nonatomic) NSString *team;
@end
