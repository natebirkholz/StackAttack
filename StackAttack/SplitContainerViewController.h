//
//  SplitContainerViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "NetworkController.h"
#import <UIKit/UIKit.h>

@interface SplitContainerViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) NetworkController *networkController;
// @property (nonatomic, strong) AppDelegate *appDelegate;  // ASKKKKKKKKKKKKKKKKKKK

@end
