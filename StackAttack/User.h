//
//  User.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSInteger reputation;
@property NSInteger user_id;
@property (nonatomic, strong) NSString *profile_image_url;
@property (nonatomic, strong) NSString *display_name;
@property (nonatomic, strong) NSString *link_url;

@end
