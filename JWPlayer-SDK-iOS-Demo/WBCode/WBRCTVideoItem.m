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
    
    if (hasData && (self = [super init]))
    {
        self.adSchedule     = (adSchedule && [adSchedule count]) ? adSchedule : nil;
        self.desc           = description;
        self.file           = file;
        self.mediaId        = mediaId;
        self.mediaSources   = (mediaSources && [mediaSources count]) ? mediaSources : nil;
        self.posterImageUrl = posterImageUrl;
        self.title          = title;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
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
        NSLog(@"Error in parsing JSON");
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}

- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem
{
    if (   playListItem
        && playListItem.file
        && [playListItem.file length] > 3
        && (self = [super init])
    )
    {
        self.desc    = playListItem.desc;
        self.file    = playListItem.file;
        self.mediaId = playListItem.mediaId;
        self.title   = playListItem.title;

        if (   playListItem.image
            && [playListItem.image rangeOfString:@"http" options:NSCaseInsensitiveSearch].location != NSNotFound
        )
        {
            self.posterImageUrl = [NSURL URLWithString:playListItem.image];
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
            
            self.mediaSources = mediaSources;
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
            
            self.adSchedule = adBreaks;
        }
    }
    
    return self;
}

- (NSDictionary *) data
{
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

    
    return @{
             @"adSchedule": adBreaks
             , @"description": self.desc
             , @"file": self.file
             , @"mediaId": self.mediaId
             , @"mediaSources": mediaSources
             , @"posterImageUrl": self.posterImageUrl ? self.posterImageUrl : @""
             , @"title": self.title
            };
}

- (NSData *) json
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWPlaylistItem *) playListItem
{
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

    playListItem.sources = sources;
    
    NSMutableArray<JWAdBreak *> *adBreaks = [NSMutableArray<JWAdBreak *> new];
    for (WBRCTAdBreak *src in self.adSchedule)
    {
        [adBreaks addObject:src.adBreak];
    }
    
    playListItem.adSchedule = adBreaks;

    return playListItem;    
}

@end
