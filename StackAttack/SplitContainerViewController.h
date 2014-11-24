//
//  SplitContainerViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface SplitContainerViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) NetworkController *networkController;
@property (nonatomic, weak) AppDelegate *appDelegate;

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController;

@end
