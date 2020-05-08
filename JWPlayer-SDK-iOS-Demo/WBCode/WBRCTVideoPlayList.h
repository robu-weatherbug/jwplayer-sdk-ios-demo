//
//  WBRCTVideoPlayList.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBRCTVideoItem.h"
#import <UIKit/UIKit.h>

@interface WBRCTVideoPlayList : NSObject

@property (nonatomic, copy) NSArray<WBRCTVideoItem *> *videoItems;

- (instancetype)initWithData:(NSArray *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem;
- (instancetype)initWithPlaylistItems:(NSArray<JWPlaylistItem *> *) playListItems;


- (NSDictionary *) data;
- (NSData *) json;
- (NSArray<JWPlaylistItem *> *) playListItems;

@end

