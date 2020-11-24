//
//  WBRCTAdRules.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTAdRules.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTAdRules

- (instancetype)initWithData:(NSDictionary *) data
{
    NSLog(@"[WBRCTAdRules::initWithData]");
    
    BOOL hasData = NO;
    
    NSNumber *frequency;
    NSNumber *startOn;
    NSNumber *startOnSeek;
    NSNumber *timeBetweenAds;
    
    if (data && [data count])
    {
        frequency      = [data parseIntegerValueForKey:@"frequency"];
        startOn        = [data parseIntegerValueForKey:@"startOn"];
        startOnSeek    = [data parseIntegerValueForKey:@"startOnSeek"];
        timeBetweenAds = [data parseIntegerValueForKey:@"timeBetweenAds"];
        
        hasData = frequency       != nil
                || startOn        != nil
                || startOnSeek    != nil
                || timeBetweenAds != nil
        ;
    }
    
    if ((self = [super init]) && hasData)
    {
        _frequency      = frequency      ? frequency.integerValue            : 0;
        // The first playlist item that will allow ad playback, index starting at 1.
        _startOn        = startOn        ? startOn.integerValue              : 1;
        _startOnSeek    = startOnSeek    ? (JWAdShown)frequency.integerValue : JWAdShownNone;
        _timeBetweenAds = timeBetweenAds ? timeBetweenAds.integerValue       : 0;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTAdRules::initWithJson] JSON: %@", json);
    
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
        NSLog(@"[WBRCTAdRules::initWithJson] Error in parsing JSON. %@", error);
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}

- (instancetype)initWithAdRules:(JWAdRules *) adRules
{
    NSLog(@"[WBRCTAdRules::initWithAdRules]");
    
    if ((self = [super init]) && adRules)
    {
        _frequency      = adRules.frequency;
        _startOn        = adRules.startOn;
        _startOnSeek    = adRules.startOnSeek;
        _timeBetweenAds = adRules.timeBetweenAds;
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSLog(@"[WBRCTAdRules::get_data]");
    
    return @{
        @"frequency":        @(self.frequency)
        , @"startOn":        @(self.startOn)
        , @"startOnSeek":    @(self.startOnSeek)
        , @"timeBetweenAds": @(self.timeBetweenAds)
    };
}

- (NSData *) json
{
    NSLog(@"[WBRCTAdRules::get_json]");
	
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWAdRules *) adRules
{
    NSLog(@"[WBRCTAdRules::get_adRules]");
    
    JWAdRules *adRules = [[JWAdRules alloc] init];
    
    NSLog(@"[WBRCTAdRules::get_adRules] self.startOn: %lu; adRules.startOn: %lu", (unsigned long)self.startOn, (unsigned long)adRules.startOn);
    
    adRules.frequency      = self.frequency;
    
    // The first playlist item that will allow ad playback, index starting at 1.
    // Within the playlist, the first index is 0. If the playlistIndex value is negative, the index starts counting from the end of the playlist.
    // Therfore, playlistIndex = 0 means startOn = 1
    // Therfore, playlistIndex = 1 means startOn = 2
    // Therfore, playlistIndex = 2 means startOn = 3
    adRules.startOn        = self.startOn;
    
    adRules.startOnSeek    = self.startOnSeek;
    adRules.timeBetweenAds = self.timeBetweenAds;
    
    return adRules;
}

@end
