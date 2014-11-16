//
//  WebViewController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (instancetype)init
{
  self = [super init];

  if (self) {

  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  self.networkController = [NetworkController sharedNetworkController];
  [self.loginButton setTitle:NSLocalizedString(@"Log In...", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender; {
  NSLog(@"Button pressed");
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  webView.navigationDelegate = self;

  NSString *urlString = [self.networkController makeRequestOAuthAccessStepOne];
  NSLog(@"------->the urlString is %@", urlString);
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [webView loadRequest:request];
  self.loginButton.hidden = YES;
  [self.view addSubview:webView];
  
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler { // I wish I had time to refactor this
  NSURLRequest *request = navigationAction.request;
  NSURL *urlFromRequest = request.URL;

  NSLog(@"LOGGING HERE");
  NSLog(@"%@", urlFromRequest.description);
  NSLog(@"%@", urlFromRequest.host);

  if ([urlFromRequest.description containsString:@"access_token"]) {
    NSLog(@"access_token received");
    [webView removeFromSuperview];
    decisionHandler(WKNavigationActionPolicyAllow);

    NSArray *components = [[urlFromRequest description] componentsSeparatedByString:@"="];

    NSString *tokenFrom = [[NSString alloc] init];
    BOOL nextString = NO;

    for (NSString *component in components) {
      if (nextString == YES) {
        tokenFrom = component;
      } else if ([component containsString:@"token"]) {
        nextString = YES;
      }
    }

    NSLog(@"The token is %@", tokenFrom);

    [[NSUserDefaults standardUserDefaults] setObject:tokenFrom forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.networkController.access_token = tokenFrom;

    NSString *key = @"hasLaunched";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL valueFor = [defaults valueForKey:key];
    NSLog(@"IIIIIIIIII %i", valueFor);
#define NSStringFromBOOL(aBOOL)    aBOOL? @"YES" : @"NO"
    NSLog(@"or also %@", NSStringFromBOOL(valueFor));

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self presentViewController:[storyboard instantiateInitialViewController] animated:true completion:nil];
  } else {
    decisionHandler(WKNavigationActionPolicyAllow);
  }
}

@end

