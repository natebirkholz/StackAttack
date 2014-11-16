//
//  WebViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkController.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate, WKNavigationDelegate>

//@property (nonatomic) AppDelegate *appDelegate;
@property (nonatomic, strong) NetworkController *networkController;

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

- (IBAction)buttonPressed:(id)sender;

@end
