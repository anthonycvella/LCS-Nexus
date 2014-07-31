//
//  GameModel.h
//  LCS Nexus
//
//  Created by Anthony Vella on 7/24/14.
//  Copyright (c) 2014 Vella, Anthony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VODModel : NSObject

@property (strong, nonatomic) NSString *embedURL;

@end

@interface PlayersModel : NSObject

@property (strong, nonatomic) NSString *name;

@end

@interface GameModel : NSObject

@property (strong, nonatomic) VODModel *vods;
@property (strong, nonatomic) NSMutableArray *players;

- (void)loadDataFromJSON:(NSString *)gameId;

@end
