//
//  QuestionSearchViewController.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkController.h"
#import "DetailViewController.h"

#import <UIKit/UIKit.h>


@interface QuestionSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, weak) AppDelegate *appDelegate;
@property (nonatomic, weak) NetworkController *networkController;


@end

