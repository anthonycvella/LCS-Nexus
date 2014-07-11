//
//  ScheduleModel.h
//  LCS Nexus
//
//  Created by Anthony Vella on 7/9/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContestantModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *logoURL;
@property (strong, nonatomic) NSString *acronym;
@property (assign, nonatomic) int wins;
@property (assign, nonatomic) int losses;

@end

@interface MatchModel : NSObject

@property (strong, nonatomic) ContestantModel *blueContestant;
@property (strong, nonatomic) ContestantModel *redContestant;
@property (strong, nonatomic) NSString *dateTime;
@property (strong, nonatomic) NSString *winnerId;

@end

@interface ScheduleModel : NSObject

- (void)loadDataFromJSON;
- (int)numberOfMatches;
- (MatchModel *)matchForIndex:(int)row;

@end
