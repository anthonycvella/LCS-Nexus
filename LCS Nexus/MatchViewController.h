//
//  MatchViewController.h
//  LCS Nexus
//
//  Created by Anthony Vella on 7/24/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface MatchViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@end
