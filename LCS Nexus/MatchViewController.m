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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) GameModel *gameModel;

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(matchDataLoaded) name:@"MatchDataLoaded" object:nil];
    
    self.gameModel = [[GameModel alloc] init];
    [self.gameModel loadDataFromJSON];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)matchDataLoaded
{
    [self.playerView loadWithVideoId:[self getYoutubeVideoID]];
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
