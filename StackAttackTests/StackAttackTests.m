//
//  StackAttackTests.m
//  StackAttackTests
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Question.h"

@interface StackAttackTests : XCTestCase

@end

@implementation StackAttackTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testQuestionParser {

  NSBundle *bundleForTests = [NSBundle bundleForClass:[self class]];
  NSString *pathForTests = [bundleForTests pathForResource:@"test2" ofType:@"json"];
  NSData *dataForTest = [NSData dataWithContentsOfFile:pathForTests];
  NSArray *questions = [Question parseJSONDataIntoQuestions:dataForTest];

  XCTAssertNotNil(questions, @"No results");

  Question *question = questions.firstObject;

  XCTAssertTrue([question.title isEqualToString:@"Objective-C: data not returned as JSON"]);

  XCTAssertTrue(questions.count == 1);
}

@end
