//
//  GameModel.m
//  LCS Nexus
//
//  Created by Anthony Vella on 7/24/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import "GameModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation GameModel

- (void)loadDataFromJSON:(NSString *)gameId
{
    self.players = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://na.lolesports.com:80/api/game/%@.json", gameId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *playersObject = [responseObject objectForKey:@"players"];
        
        for (NSString *playerKey in [playersObject allKeys]) {
            [self.players addObject:[self playersDataFromJSON:[playersObject valueForKey:playerKey]]];
        }
        self.vods = [self vodDataFromJSON:[[responseObject objectForKey:@"vods"] objectForKey:@"vod"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MatchDataLoaded" object:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (PlayersModel *)playersDataFromJSON:(NSDictionary *)playerObject
{
    PlayersModel *playersModel = [[PlayersModel alloc] init];
    playersModel.name = [playerObject objectForKey:@"name"];
    
    return playersModel;
}

- (VODModel *)vodDataFromJSON:(NSDictionary *)vodObject
{
    VODModel *vodModel = [[VODModel alloc] init];
    vodModel.embedURL = [vodObject objectForKey:@"URL"];
    
    return vodModel;
}

@end

@implementation PlayersModel

@end

@implementation VODModel

@end
