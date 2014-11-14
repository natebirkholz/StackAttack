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
    self.networkController = [NetworkController sharedNetworkController];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonPressed:(id)sender; {



  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  webView.navigationDelegate = self;

  NSString *urlString = [self.networkController makeRequestOAuthAccessStepOne];
  NSURL *url = [[NSURL alloc] initWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [webView loadRequest:request];
  self.loginButton.hidden = YES;
  [self.view addSubview:webView];
  
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  NSURLRequest *request = navigationAction.request;
  NSURL *urlFromRequest = request.URL;

  if ([urlFromRequest.description containsString:@"access_token"]) {
    [webView removeFromSuperview];
    decisionHandler(WKNavigationActionPolicyAllow);

    NSArray *components = [[urlFromRequest description] componentsSeparatedByString:@"="];

    NSString *token;
    BOOL nextString = NO;

    for (NSString *component in components) {
      if (nextString == YES) {
        token = component;
      } else if ([component containsString:@"token"]) {
        nextString = YES;
      }
    }

    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self presentViewController:[storyboard instantiateInitialViewController] animated:true completion:nil];
  } else {
    decisionHandler(WKNavigationActionPolicyAllow);
  }



}


@end

