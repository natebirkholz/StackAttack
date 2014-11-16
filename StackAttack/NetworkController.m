//
//  NetworkController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import "Question.h"


@implementation NetworkController

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)sharedNetworkController {
  static NetworkController *sharedNetworkController = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedNetworkController = [[self alloc] init];
  });
  return sharedNetworkController;
}

- (void)dealloc {
  // ARC is awesome but just in case...
}

// ########################################
#pragma mark - INIT
// ########################################


- (id) init {
    if ((self = [super init])) {

      self.imageQueue = [[NSOperationQueue alloc] init];
      self.amp = @"&";
      self.apiURL = @"https://api.stackexchange.com/";
      self.url = @"url";
      self.searchURL = @"2.2/search?order=desc&sort=activity&filter=withbody&tagged=";
      self.stackOverflowOAuthURLStepOne = @"https://stackexchange.com/oauth/dialog?";
      self.stackOverflowOAuthURL = @"stackexchange.com/oauth.login_success";
      self.scope = @"scope=no_expiry";
      self.redirectURL = @"&redirect_uri=https://stackexchange.com/oauth/login_success";
      self.clientID = @"3840";
      self.clientSecret = @"ORChu17roggtjWtY9S3OsQ((";
      self.stackOverflowPostURL = @"stackOverflowPostURL";
      self.someProperty = @"Default Property Value";
      self.key_for = @")Dwa1LBFUglgpasZ0dRQUg((";



      if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched"] == YES) {
        self.access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
      } else {
        NSLog(@"no token found");
      }

    }
    return self;
}

// ########################################
#pragma mark - Newtork Methods
// ########################################

- (NSString *) makeRequestOAuthAccessStepOne {
  
  NSArray *stringsFor = [[NSArray alloc] initWithObjects: self.stackOverflowOAuthURLStepOne, @"client_id=", self.clientID, self.amp, self.scope, self.amp, self.redirectURL, nil];
  NSString *url = [stringsFor componentsJoinedByString:(NSString *) @""];
  return url;
}

- (BOOL) checkForAuthToken {
  if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched"] == YES) {
    self.access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSLog(@"access_token is >>>>>>>>> %@", self.access_token);
    return YES;
  }
  return NO;
}

- (void) getImageFromURL:(NSString *) imageURL completionHandler:(void (^)(UIImage *imageFor))completionHandler {
  BOOL checkToken = self.checkForAuthToken;
  if (checkToken == YES) {
  [self.imageQueue addOperationWithBlock:^{
    NSURL *avatarURL = [NSURL URLWithString:imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL: avatarURL];
    UIImage *imageFor = [UIImage imageWithData: imageData];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      completionHandler(imageFor);
        }];
    }];
  } else {
    NSLog(@"No token found ------- take action");
  }
}

- (NSString *) buildAuthenticatedSearchString:(NSString *)searchString {

  NSString *tokenString = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];

  NSString *assembledString = [[NSString alloc] init];
  assembledString = [assembledString stringByAppendingString:self.apiURL];
  assembledString = [assembledString stringByAppendingString:self.searchURL];
  assembledString = [assembledString stringByAppendingString:searchString];
  assembledString = [assembledString stringByAppendingString:@"&site=stackoverflow&access_token="];
  assembledString = [assembledString stringByAppendingString:tokenString];
  assembledString = [assembledString stringByAppendingString:@"&key="];
  assembledString = [assembledString stringByAppendingString:self.key_for];

  NSLog(@"longass assembled url is %@", assembledString);

  return assembledString;
}

- (void) getQuestionsFromSearchBar:(NSString *)searchBarText completionHandler:(void (^)(NSArray *questions))completionHandler {

  NSLog(@"SearchBar text is %@", searchBarText);
  BOOL checkToken = self.checkForAuthToken;
  if (checkToken == YES) {
    NSLog(@"Token found");
  }
  NSString *searchString = [searchBarText stringByReplacingOccurrencesOfString:@" " withString: @";"];
  NSLog(@"SearchString is now %@", searchString);
  NSString *searchURL = [self buildAuthenticatedSearchString:searchString];
      NSLog(@"search url is %@", [searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
  NSURL *urlForSearch = [NSURL URLWithString:[searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

  [self getDataFromURL:urlForSearch completionHandler:^(NSData *dataFrom) {
    NSArray *arrayFrom = [Question parseJSONDataIntoQuestions:dataFrom];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      completionHandler(arrayFrom);
    }];
  }];
}

- (void) getDataFromURL:(NSURL *)urlForGet completionHandler:(void (^)(NSData *dataFrom))completionHandler {
  NSLog(@"getDataFromURL");
  NSURLSession *getSession = [NSURLSession sharedSession];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlForGet];
  request.HTTPMethod = @"GET";

  NSURLSessionDataTask *dataTask = [getSession dataTaskWithRequest:request completionHandler:^(NSData *dataFrom, NSURLResponse *resonseFrom, NSError *error) {
    if (error != nil) {
      NSLog(@"ERROR RIGHT HERE: %@", [error localizedDescription]);
      completionHandler(error);
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)resonseFrom;
      NSDictionary *strongStrings = [httpResponse allHeaderFields];
      for (NSString *item in strongStrings) {
        NSLog(@"Header item is %@", item);
      }

      [strongStrings enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        NSLog(@"The key is %@", key);
        NSLog(@"The value is %@", object);
      }];

      NSInteger statusCode = [httpResponse statusCode];
      NSLog(@"Status code is: %ld", (long)statusCode);
      switch (statusCode) {
        case 200: {
          NSLog(@"Success");
          completionHandler(dataFrom);
          break;
        }
        default: {
          NSLog(@"Fell through to default");
          NSLog(@"The code is %@", dataFrom);
          completionHandler(dataFrom);
        }
      }
    }
  }];

  [dataTask resume];
}


@end
