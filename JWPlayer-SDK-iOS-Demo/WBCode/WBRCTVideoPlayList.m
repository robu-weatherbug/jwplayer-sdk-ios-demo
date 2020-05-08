//
//  WBRCTVideoPlayList.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTVideoPlayList.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTVideoPlayList

- (instancetype)initWithData:(NSArray *) data
{
    NSMutableArray<WBRCTVideoItem *> *videoItems;
    
    if (data && [data count])
    {
        videoItems = [[NSMutableArray<WBRCTVideoItem *> alloc] init];
        
        for (id videoItemData in data)
        {
            WBRCTVideoItem *videoItem = [[WBRCTVideoItem alloc] initWithData:videoItemData];
            
            if (videoItem)
            {
                [videoItems addObject:videoItem];
            }
        }
    }
    
    if (videoItems && [videoItems count] && (self = [super init]))
    {
        self.videoItems = videoItems;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *jsonObject = [
                                NSJSONSerialization
                                JSONObjectWithData:jsonData
                                options:0
                                error:&error
                               ];
    
    if (!error)
    {
        self = [self initWithData:[jsonObject parseArrayForKey:@"playListItems"]];
    }
    else
    {
        NSLog(@"Error in parsing JSON");
    }
    
    return self;
}

- (instancetype)initWithPlaylistItem:(JWPlaylistItem *) playListItem
{
    return [self initWithPlaylistItems:[[NSArray<JWPlaylistItem *> alloc] initWithObjects:playListItem, nil]];
    
}

- (instancetype)initWithPlaylistItems:(NSArray<JWPlaylistItem *> *) playListItems
{
    NSMutableArray<WBRCTVideoItem *> *videoItems = [[NSMutableArray<WBRCTVideoItem *> alloc] initWithCapacity:playListItems.count];
    
    for (JWPlaylistItem *playListItem in playListItems)
    {
        WBRCTVideoItem *videoItem = [[WBRCTVideoItem alloc] initWithPlaylistItem:playListItem];
        
        if (videoItem)
        {
            [videoItems addObject:videoItem];
        }
    }
    
    if (videoItems && [videoItems count] && (self = [super init]))
    {
        self.videoItems = videoItems;
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSMutableArray<NSDictionary *> *playListItems = [NSMutableArray<NSDictionary *> new];
    
    for (WBRCTVideoItem *videoItem in self.videoItems)
    {
        [playListItems addObject:[videoItem data]];
    }
    
    return @{
             @"playListItems": playListItems
            };
}

- (NSData *) json
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (NSArray<JWPlaylistItem *> *) playListItems
{
    NSMutableArray<JWPlaylistItem *> *playListItems = [NSMutableArray<JWPlaylistItem *> new];
    
    for (WBRCTVideoItem *videoItem in self.videoItems)
    {
        [playListItems addObject:[videoItem playListItem]];
    }
    
    return playListItems;
}

@end
