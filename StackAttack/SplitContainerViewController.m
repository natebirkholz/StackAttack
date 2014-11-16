//
//  SplitContainerViewController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "SplitContainerViewController.h"
#import "NetworkController.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface SplitContainerViewController ()

@end

@implementation SplitContainerViewController

- (instancetype)init
{
  self = [super init];
  
  if (self) {
    NSLog(@"Do I even hit this?");
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

  self.networkController = [NetworkController sharedNetworkController];
  self.appDelegate = [[UIApplication sharedApplication] delegate];

  UISplitViewController *splitVC = self.childViewControllers[0];
  splitVC.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  if (appDelegate.hasLaunched == YES) {
    return YES;
  } else {
    return YES;
  }
}



@end

