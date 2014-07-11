//
//  ScheduleCellView.h
//  LCS Nexus
//
//  Created by Vella, Anthony on 7/8/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

@interface ScheduleCellView : UITableViewCell

- (void)setCellContent:(MatchModel *)matchModel;

@end
