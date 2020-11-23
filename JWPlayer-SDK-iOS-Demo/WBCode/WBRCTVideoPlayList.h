//
//  WBRCTVideoPlayList.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBRCTVideoItem.h"

@interface WBRCTVideoPlayList : NSObject

@property (nonatomic, copy) NSArray<WBRCTVideoItem *> *playlist;

- (instancetype)initWithData:(NSArray *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithPlaylist:(NSArray<WBRCTVideoItem *> *) playlist;
- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem;
- (instancetype)initWithPlaylistItems:(NSArray<JWPlaylistItem *> *) playListItems;

- (NSDictionary *) data;
- (NSData *) json;
- (NSArray<JWPlaylistItem *> *) playListItems;

@end

