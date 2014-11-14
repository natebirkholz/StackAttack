//
//  ViewController.m
//  StackAttack
//
//  Created by Nathan Birkholz on 11/10/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import "TimelineViewController.h"
#import "Question.h"
#import "User.h"
#import "TimelineViewTableViewCell.h"

@interface TimelineViewController ()

  @property NSArray *questions;

@end

@implementation TimelineViewController

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

  self.searchBar.delegate = self;
  self.searchBar.prompt = @"Search StackOverflow Tags...";
  self.tableView.dataSource = self;
  self.tableView.dataSource = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"TimelineViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TIMELINE_CELL"];
  [self.tableView reloadData];
}




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
  TimelineViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  cell.titleLabel.text = questionForRow.title;
  cell.bodyLabel.text = questionForRow.body;
  cell.linkLabel.text = questionForRow.link;
  NSString *tagsString = [questionForRow.tags componentsJoinedByString:(NSString *) @", "];
  cell.tagsArrayLabel.text = tagsString;
  NSInteger *currenttag = (NSInteger *)cell.tag + 1;
  cell.tag = *(currenttag);


}



func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  let cellIdentifier = "REPO_CELL"
  let repoForSection = self.repos?[indexPath.row] as Repo!
  let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as RepoCell
  cell.repoNameLabel.text = repoForSection.name as String!
  cell.repoURLLabel.text = repoForSection.repoURL.debugDescription as String!
  cell.ownerNameLabel.text = repoForSection.ownerName as String!
  cell.repoIDLabel.text = String(repoForSection.id)
  cell.imageViewAvatar.image = nil
  var currentTag = cell.tag + 1
  cell.tag = currentTag

  if self.repos?[indexPath.row].avatar != nil {
    if cell.tag == currentTag {
      cell.imageViewAvatar.image = self.repos![indexPath.row].avatar!
    }

  } else {
    cell.activityIndicator.startAnimating()
    var repoForCell = self.repos![indexPath.row] as Repo
    self.networkController.getAvatar(repoForCell.avatarURL, completionHandler: { (imageFor) -> (Void) in
      let userAvatar = imageFor as UIImage!
      UIView.transitionWithView(cell.imageView, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
        if cell.tag == currentTag {
          cell.imageViewAvatar.image = userAvatar as UIImage!
        }
        return ()
      }, completion: { (completion) -> Void in
        cell.activityIndicator.stopAnimating()
        self.repos?[indexPath.row].avatar = userAvatar!
      })
    })

  }

  return cell

}


@end
