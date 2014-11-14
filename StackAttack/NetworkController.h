//
//  NetworkController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//



#import <UIKit/UIKit.h>


@interface NetworkController : NSObject{
  NSString *someProperty;
}

@property (nonatomic, strong) NSString *amp;
@property (nonatomic, strong) NSString *apiURL;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *searchURL;
@property (nonatomic, strong) NSString *stackOverflowOAuthURL;
@property (nonatomic, strong) NSString *stackOverflowOAuthURLStepOne;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *redirectURL;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecret;
@property (nonatomic, strong) NSString *stackOverflowPostURL;
@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, strong) NSString *key_for;
@property (nonatomic, strong) NSOperationQueue *imageQueue;

+ (id)sharedNetworkController;

- (NSString *) makeRequestOAuthAccessStepOne;

- (void) getImageFromURL:(NSString *) imageURL completionHandler:(void (^)(UIImage *imageFor))completionHandler;

@end