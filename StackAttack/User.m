//
//  User.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)init:(NSDictionary *)ownerDictionary
{
  self = [super init];
  if (self) {
    self.reputation = (NSInteger)ownerDictionary[@"reputation"];
    self.user_id = (NSInteger)ownerDictionary[@"user_id"];
    self.profile_image_url = (NSString *)ownerDictionary[@"profile_image"];
    self.display_name = (NSString *)ownerDictionary[@"display_name"];
    self.link_url = (NSString *)ownerDictionary[@"link"];
  }
  return self;
}

+ (User *) parseOwnerDictionaryIntoUser:(NSDictionary*)ownerDictionary {
  User *newUser = [[User alloc] init:ownerDictionary];

  return newUser;
}


@end

