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
@property (strong, nonatomic) UIImage *teamLogo;

@end

@interface MatchModel : NSObject

@property (strong, nonatomic) ContestantModel *blueContestant;
@property (strong, nonatomic) ContestantModel *redContestant;
@property (strong, nonatomic) NSDate *dateTime;
@property (strong, nonatomic) NSString *winnerId;
@property (strong, nonatomic) NSString *roundId;

+ (NSDate *)toNSDateFromString:(NSString *)dateTime;

@end

@interface RoundModel : NSObject

@property (strong, nonatomic) NSMutableArray *matchArray;

@end

@interface ScheduleModel : NSObject

@property (strong, nonatomic, readonly) NSArray *sortedKeys;

- (void)loadDataFromJSON;
- (int)numberOfMatches;
- (int)numberOfMatchesForRound:(NSString *)round;
- (MatchModel *)matchForIndex:(int)row;
- (MatchModel *)matchForRound:(NSString *)round forIndexRow:(int)row;
- (NSArray *)sectionTitles;

@end
