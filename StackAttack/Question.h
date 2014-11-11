//
//  Question.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSDictionary *questionDictionary;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSDictionary *ownerDictionary;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *body;
@property NSInteger question_id;

@end