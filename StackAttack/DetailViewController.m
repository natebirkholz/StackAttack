//
//  DetailViewController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/11/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
