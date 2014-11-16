//
//  ViewController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "Question.h"
#import "User.h"
#import "TimelineViewTableViewCell.h"

@interface QuestionSearchViewController ()

  @property NSArray *questions;

@end

@implementation QuestionSearchViewController

- (instancetype)init
{
  self = [super init];

  if (self) {
    NSLog(@"Init method QuestionSearchViewController");

  }
  return self;
}

// ########################################
#pragma mark - Lifecycle
// ########################################

- (void)viewDidLoad {
  [super viewDidLoad];

  self.networkController = [NetworkController sharedNetworkController];
  self.appDelegate = [[UIApplication sharedApplication] delegate];

  self.searchBar.delegate = self;

  self.searchBar.prompt = [NSString stringWithFormat:NSLocalizedString(@"Search for Tags...", nil)];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"TimelineViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TIMELINE_CELL"];
  [self.tableView reloadData];
}

// ########################################
#pragma mark - TableView
// ########################################

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  if (self.questions.count > 0) {
  return self.questions.count;
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSString *cellIdentifier = @"TIMELINE_CELL";
  Question *questionForRow = self.questions[indexPath.row];
  NSDictionary *ownerForRow = questionForRow.ownerDictionary;
  User *userForRow = [User parseOwnerDictionaryIntoUser:ownerForRow];
  TimelineViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  cell.titleLabel.text = questionForRow.title;
//  cell.bodyLabel.text = questionForRow.body;
  cell.linkLabel.text = questionForRow.link;
  cell.nameLabel.text = userForRow.display_name;
  NSString *imageSource = userForRow.profile_image_url;

  NSString *tagsString = [questionForRow.tags componentsJoinedByString:(NSString *) @", "];
  cell.tagsArrayLabel.text = tagsString;
  NSInteger currenttag = cell.tag + 1;
  cell.tag = currenttag;

  [self.networkController getImageFromURL:imageSource completionHandler:^(UIImage *imageFor) {
    UIImage *avatarFor = imageFor;
    [UIView transitionWithView:cell.imageViewCell duration:0.3 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
      if (cell.tag == currenttag) {
        cell.imageViewCell.image = avatarFor;
      }
      return;
    } completion:^(BOOL finished) {
      NSLog(@"done");
    }];
  }];

  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"I'm here-------------------------------------------------------------");
  Question *selectedQuestion = self.questions[indexPath.row];

  [self performSegueWithIdentifier:@"SHOW_DET" sender:selectedQuestion];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_DET"]) {
    DetailViewController *destinationVC = segue.destinationViewController;
    Question *sentQuestion = sender;
    destinationVC.questionFor = sentQuestion;

  }
}

// ########################################
#pragma mark - SearchBar
// ########################################

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  NSString *searchText = searchBar.text;
  [searchBar resignFirstResponder];
  [self.networkController getQuestionsFromSearchBar:searchText completionHandler:^(NSArray *questions) {
    self.questions = questions;
    [self.tableView reloadData];
  }];
}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

  NSString *stringFor = text;
  NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:@"[^0-9a-zA-Z\n]" options: 0 error: nil];
  NSUInteger matchFor = [regEx numberOfMatchesInString:stringFor
                                                      options:NSMatchingWithTransparentBounds
                                                        range:NSMakeRange(0, stringFor.length)];

    if (matchFor > 0) {
      return NO;
    } else {
      return YES;
    }
  }

@end
