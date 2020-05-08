//
//  WBRCTIMASettings.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTIMASettings.h"
#import "IMASettings.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTIMASettings

- (instancetype)initWithData:(NSDictionary *) data
{
    BOOL hasData = NO;
    
    NSNumber *autoPlayAdBreaks;
    NSNumber *disableNowPlayingInfo;
    NSNumber *enableBackgroundPlayback;
    NSNumber *enableDebugMode;
    NSString *language;
    NSNumber *maxRedirects;
    NSString *playerType;
    NSString *playerVersion;
    NSString *ppid;
    
    if (data && [data count])
    {
        autoPlayAdBreaks         = [data parseBoolValueForKey:@"autoPlayAdBreaks"];
        disableNowPlayingInfo    = [data parseBoolValueForKey:@"disableNowPlayingInfo"];
        enableBackgroundPlayback = [data parseBoolValueForKey:@"enableBackgroundPlayback"];
        enableDebugMode          = [data parseBoolValueForKey:@"enableDebugMode"];
        language                 = [data parseStringForKey:@"language"];
        maxRedirects             = [data parseIntegerValueForKey:@"maxRedirects"];
        playerType               = [data parseStringForKey:@"playerType"];
        playerVersion            = [data parseStringForKey:@"playerVersion"];
        ppid                     = [data parseStringForKey:@"ppid"];
        
        hasData = autoPlayAdBreaks          != nil
                || disableNowPlayingInfo    != nil
                || enableBackgroundPlayback != nil
                || enableDebugMode          != nil
                || language
                || maxRedirects             != nil
                || playerType
                || playerVersion
                || ppid
        ;
    }
    
    if (hasData && (self = [super init]))
    {
        self.autoPlayAdBreaks         = autoPlayAdBreaks         ? autoPlayAdBreaks.boolValue         : YES;
        self.disableNowPlayingInfo    = disableNowPlayingInfo    ? disableNowPlayingInfo.boolValue    : NO;
        self.enableBackgroundPlayback = enableBackgroundPlayback ? enableBackgroundPlayback.boolValue : NO;
        self.enableDebugMode          = enableDebugMode          ? enableDebugMode.boolValue          : NO;
        self.maxRedirects             = maxRedirects             ? maxRedirects.integerValue          : 4;
        self.language                 = language;
        self.playerType               = playerType;
        self.playerVersion            = playerVersion;
        self.ppid                     = ppid;
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


- (instancetype)initWithIMASettings:(IMASettings *) imaSettings
{
    if (imaSettings && (self = [super init]))
    {
        self.autoPlayAdBreaks         = imaSettings.autoPlayAdBreaks;
        self.disableNowPlayingInfo    = imaSettings.disableNowPlayingInfo;
        self.enableBackgroundPlayback = imaSettings.enableBackgroundPlayback;
        self.enableDebugMode          = imaSettings.enableDebugMode;
        self.language                 = imaSettings.language;
        self.maxRedirects             = imaSettings.maxRedirects;
        self.playerType               = imaSettings.playerType;
        self.playerVersion            = imaSettings.playerVersion;
        self.ppid                     = imaSettings.ppid;
    }
    
    return self;
}

- (NSDictionary *) data
{
    return @{
             @"autoPlayAdBreaks":           @(self.autoPlayAdBreaks)
             , @"disableNowPlayingInfo":    @(self.disableNowPlayingInfo)
             , @"enableBackgroundPlayback": @(self.enableBackgroundPlayback)
             , @"enableDebugMode":          @(self.enableDebugMode)
             , @"language":                 self.language
             , @"maxRedirects":             @(self.maxRedirects)
             , @"playerType":               self.playerType
             , @"playerVersion":            self.playerVersion
             , @"ppid":                     self.ppid
            };
}

- (NSData *) json
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (IMASettings *) imaSettings
{
    IMASettings *imaSettings = [[IMASettings alloc] init];
    
    if (imaSettings)
    {
        imaSettings.autoPlayAdBreaks         = self.autoPlayAdBreaks;
        imaSettings.disableNowPlayingInfo    = self.disableNowPlayingInfo;
        imaSettings.enableBackgroundPlayback = self.enableBackgroundPlayback;
        imaSettings.enableDebugMode          = self.enableDebugMode;
        imaSettings.language                 = self.language;
        imaSettings.maxRedirects             = self.maxRedirects;
        imaSettings.playerType               = self.playerType;
        imaSettings.playerVersion            = self.playerVersion;
        imaSettings.ppid                     = self.ppid;
    }
    
    return imaSettings;
}

@end
