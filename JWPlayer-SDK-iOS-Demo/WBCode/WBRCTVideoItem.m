//
//  WBRCTVideoItem.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTVideoItem.h"
#import "NSDictionary+Converters.h"
#import <JWPlayer_iOS_SDK/JWSource.h>

@implementation WBRCTVideoItem

- (instancetype)initWithData:(NSDictionary *) data
{
    NSLog(@"[WBRCTVideoItem::initWithData]");
    
    BOOL hasData = false;
    
    NSString *description;
    NSString *file;
    NSString *mediaId;
    NSString *title;
    NSURL *posterImageUrl;
    NSMutableArray<WBRCTMediaSource *> *mediaSources;
    NSMutableArray<WBRCTAdBreak *> *adSchedule;
    
    if (data && [data count])
    {
        description    = [data parseStringForKey:@"description"];
        file           = [data parseStringForKey:@"file"];
        mediaId        = [data parseStringForKey:@"mediaId"];
        posterImageUrl = [data parseUrlForKey:@"posterImageUrl"];
        title          = [data parseStringForKey:@"title"];
        
        NSArray<NSString *> *sources = [data parseArrayForKey:@"mediaSources"];
        if (sources && [sources count])
        {
            mediaSources = [[NSMutableArray<WBRCTMediaSource *> alloc] init];
            
            for (id source in sources)
            {
                WBRCTMediaSource *mediaSource = [[WBRCTMediaSource alloc] initWithData:source];
                
                if (mediaSource)
                {
                    [mediaSources addObject:mediaSource];
                }
            }
        }
        
        NSArray<NSString *> *schedules = [data parseArrayForKey:@"adSchedule"];
        if (schedules && [schedules count])
        {
            adSchedule = [[NSMutableArray<WBRCTAdBreak *> alloc] init];
            
            for (id schedule in schedules)
            {
                WBRCTAdBreak *adBreak = [[WBRCTAdBreak alloc] initWithData:schedule];
                
                if (adBreak)
                {
                    [adSchedule addObject:adBreak];
                }
            }
        }
        
        hasData =  description
                || file
                || title
                || mediaId
                || (mediaSources && [mediaSources count])
                || (adSchedule && [adSchedule count])
                || posterImageUrl
        ;
    }
    
    if ((self = [super init]) && hasData)
    {
        _adSchedule     = (adSchedule && [adSchedule count]) ? adSchedule : nil;
        _desc           = description;
        _file           = file;
        _mediaId        = mediaId;
        _mediaSources   = (mediaSources && [mediaSources count]) ? mediaSources : nil;
        _posterImageUrl = posterImageUrl;
        _title          = title;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTVideoItem::initWithJson] JSON: %@", json);
    
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary  *jsonObject = [
                                 NSJSONSerialization
                                 JSONObjectWithData:jsonData
                                 options:0
                                 error:&error
                                 ];
    
    if (error)
    {
        NSLog(@"[WBRCTVideoItem::initWithJson] Error in parsing JSON. %@", error);
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}

- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem
{
    NSLog(@"[WBRCTVideoItem::initWithPlaylistItem]");
    
    if (   (self = [super init])
        && playListItem
        && playListItem.file
        && [playListItem.file length] > 3
    )
    {
        _desc    = playListItem.desc;
        _file    = playListItem.file;
        _mediaId = playListItem.mediaId;
        _title   = playListItem.title;
        
        if (   playListItem.image
            && [playListItem.image rangeOfString:@"http" options:NSCaseInsensitiveSearch].location != NSNotFound
        )
        {
            _posterImageUrl = [NSURL URLWithString:playListItem.image];
        }
        
        if (playListItem.sources && [playListItem.sources count])
        {
            NSMutableArray<WBRCTMediaSource *> *mediaSources = [NSMutableArray<WBRCTMediaSource *> new];
            
            for (JWSource *source in playListItem.sources)
            {
                WBRCTMediaSource *mediaSource = [[WBRCTMediaSource alloc] initWithSource:source];
                
                if (mediaSource)
                {
                    [mediaSources addObject:mediaSource];
                }
            }
            
            _mediaSources = [mediaSources count] ? mediaSources : nil;
        }
        
        if (playListItem.adSchedule && [playListItem.adSchedule count])
        {
            NSMutableArray<WBRCTAdBreak *> *adBreaks = [NSMutableArray<WBRCTAdBreak *> new];
            
            for (JWAdBreak *schedule in playListItem.adSchedule)
            {
                WBRCTAdBreak *adBreak = [[WBRCTAdBreak alloc] initWithAdBreak:schedule];
                
                if (adBreak)
                {
                    [adBreaks addObject:adBreak];
                }
            }
            
            _adSchedule = [adBreaks count] ? adBreaks : nil;
        }
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSLog(@"[WBRCTVideoItem::get_data]");
    
    NSMutableArray<NSDictionary *> *mediaSources = [NSMutableArray<NSDictionary *> new];
    
    for (WBRCTMediaSource *src in self.mediaSources)
    {
        [mediaSources addObject:src.data];
    }
    
    NSMutableArray<NSDictionary *> *adBreaks = [NSMutableArray<NSDictionary *> new];
    
    for (WBRCTAdBreak *src in self.adSchedule)
    {
        [adBreaks addObject:src.data];
    }
    
    NSMutableDictionary *results = [@{
        @"description": self.desc
        , @"file": self.file
        , @"mediaId": self.mediaId
        , @"posterImageUrl": self.posterImageUrl ? self.posterImageUrl : @""
        , @"title": self.title
    } mutableCopy];
    
    if ([adBreaks count])
    {
        [results setObject:adBreaks forKey:@"adSchedule"];
    }
    
    if (mediaSources && [mediaSources count])
    {
        [results setObject:mediaSources forKey:@"mediaSources"];
    }
    
    return results;
}

- (NSData *) json
{
    NSLog(@"[WBRCTVideoItem::get_json]");
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWPlaylistItem *) playListItem
{
    NSLog(@"[WBRCTVideoItem::get_playListItem]");
    
    JWPlaylistItem * playListItem = [JWPlaylistItem new];
    
    playListItem.desc    = self.desc;
    playListItem.file    = self.file;
    playListItem.mediaId = self.mediaId;
    playListItem.image   = [self.posterImageUrl absoluteString];
    playListItem.title   = self.title;
    
    NSMutableArray<JWSource *> *sources = [NSMutableArray<JWSource *> new];
    for (WBRCTMediaSource *src in self.mediaSources)
    {
        [sources addObject:src.source];
    }
    
    playListItem.sources = [sources count] ? sources : nil;
    
    NSMutableArray<JWAdBreak *> *adBreaks = [NSMutableArray<JWAdBreak *> new];
    for (WBRCTAdBreak *src in self.adSchedule)
    {
        [adBreaks addObject:src.adBreak];
    }
    
    playListItem.adSchedule = [adBreaks count] ? adBreaks : nil;

    
    return playListItem;
}

@end
