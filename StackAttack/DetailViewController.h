//
//  DetailViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkController.h"

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NetworkController *networkController;
@property (nonatomic, weak) AppDelegate *appDelegate;

@end
