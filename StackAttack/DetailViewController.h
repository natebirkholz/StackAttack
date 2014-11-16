//
//  DetailViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkController.h"
#import "Question.h"
#import "User.h"

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController 

@property (nonatomic, strong) NetworkController *networkController;
@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, strong) Question *questionFor;
@property (nonatomic, strong) User *userFor;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
