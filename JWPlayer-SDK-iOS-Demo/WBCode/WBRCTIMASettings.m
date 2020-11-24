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
    NSLog(@"[WBRCTIMASettings::initWithData]");
    
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
    
    if ((self = [super init]) && hasData)
    {
        _autoPlayAdBreaks         = autoPlayAdBreaks         ? autoPlayAdBreaks.boolValue         : YES;
        _disableNowPlayingInfo    = disableNowPlayingInfo    ? disableNowPlayingInfo.boolValue    : NO;
        _enableBackgroundPlayback = enableBackgroundPlayback ? enableBackgroundPlayback.boolValue : NO;
        _enableDebugMode          = enableDebugMode          ? enableDebugMode.boolValue          : NO;
        _maxRedirects             = maxRedirects             ? maxRedirects.integerValue          : 4;
        _language                 = language;
        _playerType               = playerType;
        _playerVersion            = playerVersion;
        _ppid                     = ppid;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTIMASettings::initWithJson] JSON: %@", json);
    
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
        NSLog(@"[WBRCTIMASettings::initWithJson] Error in parsing JSON. %@", error);
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}


- (instancetype)initWithIMASettings:(IMASettings *) imaSettings
{
    NSLog(@"[WBRCTIMASettings::initWithIMASettings]");
    
    if ((self = [super init]) && imaSettings)
    {
        _autoPlayAdBreaks         = imaSettings.autoPlayAdBreaks;
        _disableNowPlayingInfo    = imaSettings.disableNowPlayingInfo;
        _enableBackgroundPlayback = imaSettings.enableBackgroundPlayback;
        _enableDebugMode          = imaSettings.enableDebugMode;
        _language                 = imaSettings.language;
        _maxRedirects             = imaSettings.maxRedirects;
        _playerType               = imaSettings.playerType;
        _playerVersion            = imaSettings.playerVersion;
        _ppid                     = imaSettings.ppid;
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSLog(@"[WBRCTIMASettings::get_data]");
    
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
    NSLog(@"[WBRCTIMASettings::get_json]");
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (IMASettings *) imaSettings
{
    NSLog(@"[WBRCTIMASettings::get_imaSettings]");
    
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
