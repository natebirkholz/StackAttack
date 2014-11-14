//
//  TimelineViewTableViewCell.h
//  StackAttack
//
//  Created by Nathan Birkholz on 11/12/14.
//  Copyright (c) 2014 Nate Birkholz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UILabel *tagsArrayLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
