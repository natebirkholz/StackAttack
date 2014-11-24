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

  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.networkController = [NetworkController sharedNetworkController];
  self.appDelegate = [[UIApplication sharedApplication] delegate];
  NSDictionary *ownerFor = self.questionFor.ownerDictionary;
  self.userFor = [User parseOwnerDictionaryIntoUser:ownerFor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear: animated];
  self.titleLabel.text = self.questionFor.title;
  self.bodyLabel.text = self.questionFor.body;
  NSString *tagsString = [self.questionFor.tags componentsJoinedByString:(NSString *) @", "];
  self.tagsLabel.text = tagsString;
  self.urlLabel.text = self.questionFor.link;
  NSDictionary *ownerFrom = (NSDictionary *)self.questionFor.questionDictionary[@"owner"];
  NSString *urlForImage = (NSString *)ownerFrom[@"profile_image"];
  self.userNameLabel.text = self.userFor.display_name;
  [self.networkController getImageFromURL:urlForImage completionHandler:^(UIImage *imageFor) {
    self.imageView.image = imageFor;
    self.userFor.user_avatar = imageFor;
  }];
}

@end
