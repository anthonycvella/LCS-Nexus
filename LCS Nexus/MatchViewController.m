//
//  MatchViewController.m
//  LCS Nexus
//
//  Created by Anthony Vella on 7/24/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "MatchViewController.h"
#import "GameModel.h"

@interface MatchViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *leftTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *rightTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *leftTeamName;
@property (weak, nonatomic) IBOutlet UILabel *rightTeamName;
@property (weak, nonatomic) IBOutlet UILabel *playedOnDate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) GameModel *gameModel;

@end

@implementation MatchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(matchDataLoaded) name:@"MatchDataLoaded" object:nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    self.playedOnDate.text = [formatter stringFromDate:self.matchModel.dateTime];
    
    self.leftTeamName.text = self.matchModel.blueContestant.acronym;
    self.rightTeamName.text = self.matchModel.redContestant.acronym;
    
    NSString *urlString = @"http://na.lolesports.com/";
    
    if (self.matchModel.blueContestant.teamLogo == nil || self.matchModel.redContestant.teamLogo == nil) {
        self.leftTeamLogo.image = [UIImage imageNamed:@"first"];
        self.rightTeamLogo.image = [UIImage imageNamed:@"second"];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            self.matchModel.blueContestant.teamLogo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, self.matchModel.blueContestant.logoURL]]]];
            self.matchModel.redContestant.teamLogo = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, self.matchModel.redContestant.logoURL]]]];
            
            if (self.matchModel.blueContestant.teamLogo == nil) {
                self.matchModel.blueContestant.teamLogo = [UIImage imageNamed:@"first"];
            }
            if (self.matchModel.redContestant.teamLogo == nil) {
                self.matchModel.redContestant.teamLogo = [UIImage imageNamed:@"second"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                self.leftTeamLogo.image = self.matchModel.blueContestant.teamLogo;
                self.rightTeamLogo.image = self.matchModel.redContestant.teamLogo;
            });
        });
    } else {
        self.leftTeamLogo.image = self.matchModel.blueContestant.teamLogo;
        self.rightTeamLogo.image = self.matchModel.redContestant.teamLogo;
    }
    
    self.gameModel = [[GameModel alloc] init];
    [self.gameModel loadDataFromJSON:self.gameId];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)matchDataLoaded
{
    self.playerView.alpha = 0;
    [self.playerView loadWithVideoId:[self getYoutubeVideoID]];
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.playerView.alpha = 1;
    } completion:nil];
}

- (NSString *)getYoutubeVideoID
{
    NSString *embedURL = self.gameModel.vods.embedURL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?:.*v=)([^&]+)"
                                              options:NSRegularExpressionCaseInsensitive
                                                error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:embedURL
                                                    options:0
                                                      range:NSMakeRange(0, [embedURL length])];
    if (match) {
        NSRange videoIDRange = [match rangeAtIndex:1];
        
        return [embedURL substringWithRange:videoIDRange];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
