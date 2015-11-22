//
//  APIMessage.h
//  FoiPaintball
//
//  Created by Azzaro Mujic on 22/11/15.
//  Copyright © 2015 Infinum. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface APIMessage : JSONModel
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *sender_name;
@property (strong, nonatomic) NSString<Optional> *team;
@end
