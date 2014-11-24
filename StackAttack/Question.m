//
//  Question.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "Question.h"

@implementation Question

- (instancetype)init:(NSDictionary *)questionDictionary
{
  self = [super init];
  if (self) {
    self.networkController = [NetworkController sharedNetworkController];
    self.questionDictionary = questionDictionary;
    self.tags = (NSArray *)questionDictionary[@"tags"];
    self.ownerDictionary = (NSDictionary *)questionDictionary[@"owner"];
    self.link = (NSString *)questionDictionary[@"link"];
    self.title = (NSString *)questionDictionary[@"title"];
    self.body = (NSString *)questionDictionary[@"body"];
    NSString *urlForImage = [questionDictionary valueForKeyPath:@"owner.profile_image"];
    __block UIImage *imageForIs = [[UIImage alloc] init];
    [self.networkController getImageFromURL:urlForImage completionHandler:^(UIImage *imageFor) {
       imageForIs = (UIImage *)imageFor;
    }];
    self.avatar = imageForIs;
  }
  return self;
}

+ (NSArray *)parseJSONDataIntoQuestions:(NSData *)rawJSonData {

  NSError *error;
  NSLog(@"%@", error.localizedDescription);
  NSDictionary *topDictionary = [NSJSONSerialization JSONObjectWithData:rawJSonData options:NSJSONReadingAllowFragments error:&error];
  NSArray *JSONArray = (NSArray *)topDictionary[@"items"];
  NSLog(@"Found this in items: %@", topDictionary[@"items"]);
  NSMutableArray *questions = [[NSMutableArray alloc]init];

  for (NSDictionary *JSonDictionary in JSONArray) {
    Question *newQuestion = [[Question alloc] init:JSonDictionary];
    [questions addObject:newQuestion];
  }
  return questions;
}


@end


