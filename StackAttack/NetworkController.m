//
//  NetworkController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import <UIKit/UIKit.h>

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

      self.apiURL = @"apiURL";
      self.url = @"url";
      self.stackOverflowOAuthURL = @"stackOverflowOAuthURL";
      self.scope = @"scope";
      self.redirectURL = @"redirectURL";
      self.clientID = @"clientID";
      self.clientSecret = @"clientSecret";
      self.stackOverflowPostURL = @"stackOverflowPostURL";
      self.someProperty = @"Default Property Value";

    }
    return self;
}

- (void) requestOAuthAccess {
  NSArray *stringsFor = [[NSArray alloc] initWithObjects: self.stackOverflowOAuthURL, self.clientID, @"&", self.scope, nil];
  NSString *url = [stringsFor componentsJoinedByString:(NSString *) @""];
  [[UIApplication sharedApplication] openURL:(NSURL *) url];
  
}

-(void) handleOAuthURL:(NSURL *) callbackURL completionHandler:(void (^)(BOOL successIs))completionHandler {

  NSString *query = callbackURL.query;
  NSArray *components = [query componentsSeparatedByString:@"code="];
  NSString *code = components.lastObject;


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