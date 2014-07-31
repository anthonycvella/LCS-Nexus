//
//  MatchCellView.m
//  LCS Nexus
//
//  Created by Anthony Vella on 7/29/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "MatchCellView.h"

@implementation MatchCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
