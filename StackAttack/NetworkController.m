//
//  NetworkController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"


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
  // Should never be called, but just here for clarity really.
}


- (id) init {
    if ((self = [super init])) {

      self.imageQueue = [[NSOperationQueue alloc] init];
      self.amp = @"&";
      self.apiURL = @"api.stackexchange.com/";
      self.url = @"url";
      self.searchURL = @"/2.2/search?order=desc&sort=activity&site=stackoverflow&filter=withbody&tagged=";
      self.stackOverflowOAuthURLStepOne = @"https://stackexchange.com/oauth/dialog?";
      self.stackOverflowOAuthURL = @"stackexchange.com/oauth.login_success";
      self.scope = @"scope=no_expiry";
      self.redirectURL = @"&redirect_uri=https://stackexchange.com/oauth/login_success";
      self.clientID = @"3840";
      self.clientSecret = @"ORChu17roggtjWtY9S3OsQ((";
      self.stackOverflowPostURL = @"stackOverflowPostURL";
      self.someProperty = @"Default Property Value";
      self.key_for = @")Dwa1LBFUglgpasZ0dRQUg((";

    }
    return self;
}

- (NSString *) makeRequestOAuthAccessStepOne {
  
  NSArray *stringsFor = [[NSArray alloc] initWithObjects: self.stackOverflowOAuthURLStepOne, @"client_id=", self.clientID, self.amp, self.scope, self.amp, self.redirectURL, nil];
  NSString *url = [stringsFor componentsJoinedByString:(NSString *) @""];
  NSLog(@" In makeRequestOAuthAccessStepOne, url is %@", url);
  return url;

}



-(void) handleOAuthURL:(NSURL *) callbackURL completionHandler:(void (^)(BOOL successIs))completionHandler {

  NSString *query = callbackURL.query;
  NSArray *components = [query componentsSeparatedByString:@"code="];
  NSString *code = components.lastObject;
  NSString *amp = @"&";
  NSString *urlQuery = self.clientID;
  urlQuery = [urlQuery stringByAppendingString:amp];
  urlQuery = [urlQuery stringByAppendingString:self.clientSecret];
  urlQuery = [urlQuery stringByAppendingString:amp];
  NSString *codeString = (@"code=%@", code);
  urlQuery = [urlQuery stringByAppendingString:codeString];

}

- (void) getImageFromURL:(NSString *) imageURL completionHandler:(void (^)(UIImage *imageFor))completionHandler {
  [self.imageQueue addOperationWithBlock:^{
    NSURL *avatarURL = [NSURL URLWithString:imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL: avatarURL];
    UIImage *imageFor = [UIImage imageWithData: imageData];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

      completionHandler(imageFor);
        }];
    }];
}



@end


/*

 func handleOAuthURL(callbackURL: NSURL, completionHandler: (successIs: Bool) -> (Void)) {
 //        Use OAuth Access to generate OAuth token
 let query = callbackURL.query
 let components = query?.componentsSeparatedByString("code=")
 let code = components?.last!
 let urlQuery = self.clientID + "&" + self.clientSecret + "&" + "code=\(code!)"
 var request = NSMutableURLRequest(URL: NSURL(string: gitHubPostURL)!)
 request.HTTPMethod = "POST"
 var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
 let length = postData!.length
 request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
 request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
 request.HTTPBody = postData

 let datatask: Void = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
 if error != nil {
 print("alert: ERROR is ")
 println(error.localizedDescription)
 } else {
 if let httpResponse = response as? NSHTTPURLResponse {
 switch httpResponse.statusCode {
 case 200...204:
 var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
 let tokenComponents = tokenResponse?.componentsSeparatedByString("=")
 let tokenSeed = tokenComponents?[1].componentsSeparatedByString("&")
 let tokenFor = tokenSeed?.first! as String!
 let key = "OAuthToken"
 NSUserDefaults.standardUserDefaults().setValue(tokenFor, forKey: key)
 NSUserDefaults.standardUserDefaults().synchronize()
 completionHandler(successIs: true)
 default:
 println("default")
 completionHandler(successIs: false)
 }
 }
 }
 }) .resume()

 } 
*/