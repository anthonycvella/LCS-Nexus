//
//  ScheduleCellView.m
//  LCS Nexus
//
//  Created by Vella, Anthony on 7/8/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "ScheduleCellView.h"
#import "ScheduleTableViewController.h"

@interface ScheduleCellView()

@property (weak, nonatomic) IBOutlet UIImageView *leftTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *rightTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamName;
@property (weak, nonatomic) IBOutlet UILabel *rightTeamName;

@property (weak, nonatomic) ScheduleTableViewController *scheduleTableViewController;

@end

@implementation ScheduleCellView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellContent
{
    //self.leftTeamLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[self.scheduleTableViewController.scheduleJSONData objectForKey:@"acronym"]]];
}

@end
