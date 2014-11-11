//
//  NetworkController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject{
  NSString *someProperty;
}

@property (nonatomic, strong) NSString *apiURL;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *stackOverflowOAuthURL;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *redirectURL;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *stackOverflowPostURL;
@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedNetworkController;

- (void) requestOAuthAccess;

@end