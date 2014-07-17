//
//  ScheduleCellView.m
//  LCS Nexus
//
//  Created by Vella, Anthony on 7/8/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "ScheduleCellView.h"
#import "ScheduleTableViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ScheduleCellView()

@property (weak, nonatomic) IBOutlet UIImageView *leftTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *rightTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamName;
@property (weak, nonatomic) IBOutlet UILabel *rightTeamName;
@property (weak, nonatomic) IBOutlet UILabel *matchDate;

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

- (void)setCellContent:(MatchModel *)matchModel
{
    self.leftTeamName.text = matchModel.blueContestant.acronym;
    self.rightTeamName.text = matchModel.redContestant.acronym;
    
    self.matchDate.text = [matchModel.dateTime description];
    
    NSString *urlString = @"http://na.lolesports.com/";
    
    if (matchModel.blueContestant.teamLogo == nil || matchModel.redContestant.teamLogo == nil) {
        self.leftTeamLogo.image = [UIImage imageNamed:@"first"];
        self.rightTeamLogo.image = [UIImage imageNamed:@"second"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            matchModel.blueContestant.teamLogo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, matchModel.blueContestant.logoURL]]]];
            matchModel.redContestant.teamLogo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, matchModel.redContestant.logoURL]]]];
            
            if (matchModel.blueContestant.teamLogo == nil) {
                matchModel.blueContestant.teamLogo = [UIImage imageNamed:@"first"];
            }
            if (matchModel.redContestant.teamLogo == nil) {
                matchModel.redContestant.teamLogo = [UIImage imageNamed:@"second"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                self.leftTeamLogo.image = matchModel.blueContestant.teamLogo;
                self.rightTeamLogo.image = matchModel.redContestant.teamLogo;
            });
        });
    } else {
        self.leftTeamLogo.image = matchModel.blueContestant.teamLogo;
        self.rightTeamLogo.image = matchModel.redContestant.teamLogo;
    }
}

@end
