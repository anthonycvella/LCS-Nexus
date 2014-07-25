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

- (void)loadDataFromJSON
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://na.lolesports.com:80/api/game/3045.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *gameObject = responseObject;
        
        self.vods = [self vodDataFromJSON:[[gameObject objectForKey:@"vods"] objectForKey:@"vod"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MatchDataLoaded" object:self];
        
        NSLog(@"GAME DATA: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (VODModel *)vodDataFromJSON:(NSDictionary *)vodObject
{
    VODModel *vodModel = [[VODModel alloc] init];
    vodModel.embedURL = [vodObject objectForKey:@"URL"];
    
    return vodModel;
}

@end

@implementation VODModel

@end
