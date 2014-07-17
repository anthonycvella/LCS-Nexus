//
//  ScheduleModel.m
//  LCS Nexus
//
//  Created by Anthony Vella on 7/9/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "ScheduleModel.h"
#import <AFNetworking/AFNetworking.h>

@interface ScheduleModel()

@property (strong, nonatomic) NSMutableArray *matchArray;

@end

@implementation ScheduleModel

- (void)loadDataFromJSON
{
    self.matchArray = [NSMutableArray array];
    
    NSDictionary *parameters = @{@"tournamentId": @"104"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://na.lolesports.com:80/api/schedule.json?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSString *matchKey in responseObject) {
            NSDictionary *matchObject = [responseObject valueForKey:matchKey];
            MatchModel *currentMatch = [[MatchModel alloc] init];
            currentMatch.dateTime = [matchObject objectForKey:@"dateTime"];
            currentMatch.winnerId = [matchObject objectForKey:@"winnerId"];
            
            NSDictionary *contestantsObject = [matchObject objectForKey:@"contestants"];
            if ([contestantsObject isKindOfClass:[NSDictionary class]]) {
                currentMatch.blueContestant = [self contestantDataFromJSON:[contestantsObject objectForKey:@"blue"]];
                currentMatch.redContestant = [self contestantDataFromJSON:[contestantsObject objectForKey:@"red"]];
            }
            
            [self.matchArray addObject:currentMatch];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MatchDataLoaded" object:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (ContestantModel *)contestantDataFromJSON:(NSDictionary *)contestantObject
{
    ContestantModel *currentContestant = [[ContestantModel alloc] init];
    currentContestant.name = [contestantObject objectForKey:@"name"];
    currentContestant.logoURL = [contestantObject objectForKey:@"logoURL"];
    currentContestant.acronym = [contestantObject objectForKey:@"acronym"];
    currentContestant.wins = [[contestantObject objectForKey:@"wins"] intValue];
    currentContestant.losses = [[contestantObject objectForKey:@"losses"] intValue];
    currentContestant.teamLogo = nil;
    
    return currentContestant;
}

- (int)numberOfMatches
{
    return self.matchArray.count;
}

- (MatchModel *)matchForIndex:(int)row
{
    return [self.matchArray objectAtIndex:row];
}

@end

@implementation MatchModel

- (NSString *)toStringFromDateTime:(NSDate *)dateTime;
{
    NSLog(@"%@", dateTime);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm'Z'";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    dateFormatter.dateFormat = @"EEEE,MMM d";
    NSString *matchDateString = [dateFormatter stringFromDate:dateTime];
    
    NSLog(@"MATCH %@", matchDateString);
    return matchDateString;
}

@end

@implementation ContestantModel


@end