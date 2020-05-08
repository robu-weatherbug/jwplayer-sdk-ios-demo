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
    
    if (hasData && (self = [super init]))
    {
        self.frequency      = frequency      ? frequency.integerValue            : 0;
        self.startOn        = startOn        ? startOn.integerValue              : 1;
        self.startOnSeek    = startOnSeek    ? (JWAdShown)frequency.integerValue : JWAdShownNone;
        self.timeBetweenAds = timeBetweenAds ? timeBetweenAds.integerValue       : 0;
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

- (instancetype)initWithAdRules:(JWAdRules *) adRules
{
    if (adRules && (self = [super init]))
    {
        self.frequency      = adRules.frequency;
        self.startOn        = adRules.startOn;
        self.startOnSeek    = adRules.startOnSeek;
        self.timeBetweenAds = adRules.timeBetweenAds;
    }
    
    return self;
}

- (NSDictionary *) data
{
    return @{
             @"frequency":        @(self.frequency)
             , @"startOn":        @(self.startOn)
             , @"startOnSeek":    @(self.startOnSeek)
             , @"timeBetweenAds": @(self.timeBetweenAds)
            };
}

- (NSData *) json
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWAdRules *) adRules
{
    JWAdRules *adRules = [[JWAdRules alloc] init];
    
    adRules.frequency      = self.frequency;
    adRules.startOn        = self.startOn;
    adRules.startOnSeek    = self.startOnSeek;
    adRules.timeBetweenAds = self.timeBetweenAds;
    
    return adRules;
}

@end
