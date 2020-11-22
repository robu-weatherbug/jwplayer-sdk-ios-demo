//
//  WBRCTVideoItem.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBRCTAdBreak.h"
#import "WBRCTMediaSource.h"
#import <JWPlayer_iOS_SDK/JWPlaylistItem.h>

@interface WBRCTVideoItem : NSObject

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *mediaId;
@property (nonatomic, strong) NSURL *posterImageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<WBRCTMediaSource *> *mediaSources;
@property (nonatomic, copy) NSArray<WBRCTAdBreak *> *adSchedule;

- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem;

- (NSDictionary *) data;
- (NSData *) json;
- (JWPlaylistItem *) playListItem;

@end
