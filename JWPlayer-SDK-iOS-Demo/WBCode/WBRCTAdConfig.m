//
//  WBRCTAdConfig.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTAdConfig.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTAdConfig

- (instancetype)initWithData:(NSDictionary *) data
{
    NSLog(@"[WBRCTAdConfig::initWithData]");
    
    BOOL hasData = NO;
    
    NSString *adMessage;
    NSString *adVmap;
    NSNumber *client;
    WBRCTIMASettings *googimaSettings;
    WBRCTAdRules *rules;
    NSMutableArray<WBRCTAdBreak *> *adBreaks;
    NSString *skipMessage;
    NSNumber *skipOffset;
    NSString *skipText;
    NSString *tag;
    NSNumber *vpaidControls;
    
    if (data && [data count])
    {
        adMessage     = [data parseStringForKey:@"adMessage"];
        adVmap        = [data parseStringForKey:@"adVmap"];
        client        = [data parseIntegerValueForKey:@"client"];
        skipMessage   = [data parseStringForKey:@"skipMessage"];
        skipOffset    = [data parseIntegerValueForKey:@"skipOffset"];
        skipText      = [data parseStringForKey:@"skipText"];
        tag           = [data parseStringForKey:@"tag"];
        vpaidControls = [data parseIntegerValueForKey:@"vpaidControls"];
        
        NSDictionary *imaSettingsData = [data parseDictionaryForKey:@"googimaSettings"];
        if (imaSettingsData && [imaSettingsData count])
        {
            googimaSettings = [[WBRCTIMASettings alloc] initWithData:imaSettingsData];
        }
        
        NSDictionary *rulesData = [data parseDictionaryForKey:@"rules"];
        if (rulesData && [rulesData count])
        {
            rules = [[WBRCTAdRules alloc] initWithData:rulesData];
        }
        
        NSArray<NSString *> *schedules = [data parseArrayForKey:@"schedule"];
        if (schedules && [schedules count])
        {
            adBreaks = [[NSMutableArray<WBRCTAdBreak *> alloc] init];
            for (id sch in schedules)
            {
                WBRCTAdBreak *adBreak = [[WBRCTAdBreak alloc] initWithData:sch];
                if (adBreak)
                {
                    [adBreaks addObject:adBreak];
                }
            }
        }
        
        hasData =  adMessage
                || adVmap
                || client != nil
                || googimaSettings
                || rules
                || (adBreaks && [adBreaks count])
                || skipMessage
                || skipOffset != nil
                || skipText
                || tag
                || vpaidControls != nil
        ;
    }
    
    if ((self = [super init]) && hasData)
    {
        _adMessage       = adMessage;
        _adVmap          = adVmap;
        _client          = client ? (JWAdClient)client.integerValue : JWAdClientVast;
        _googimaSettings = googimaSettings;
        _rules           = rules;
        _schedule        = (adBreaks && [adBreaks count]) ? adBreaks : nil;
        _skipMessage     = skipMessage;
        _skipOffset      = skipOffset ? skipOffset.integerValue : 0;
        _skipText        = skipText;
        _tag             = tag;
        _vpaidControls   = vpaidControls ? vpaidControls.boolValue : NO;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTAdConfig::initWithJson] JSON: %@", json);
    
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
        NSLog(@"[WBRCTAdConfig::initWithJson] Error in parsing JSON. %@", error);
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}

- (instancetype)initWithAdConfig:(JWAdConfig *) adConfig
{
    NSLog(@"[WBRCTAdConfig::initWithAdConfig]");
    
    BOOL hasData = adConfig
                || (adConfig.adMessage && [adConfig.adMessage length])
                || (adConfig.adVmap    && [adConfig.adVmap length])
                || (adConfig.client == JWAdClientVast || adConfig.client == JWAdClientGoogima)
                || adConfig.googimaSettings
                || adConfig.rules
                || (adConfig.schedule    && [adConfig.schedule count])
                || (adConfig.skipMessage && [adConfig.skipMessage length])
                || (adConfig.skipText    && [adConfig.skipText length])
                || (adConfig.tag         && [adConfig.tag length])
    ;
    
    if ((self = [super init]) && hasData)
    {
        _adMessage       = adConfig.adMessage;
        _adVmap          = adConfig.adVmap;
        _client          = adConfig.client;
        _skipMessage     = adConfig.skipMessage;
        _skipOffset      = adConfig.skipOffset;
        _skipText        = adConfig.skipText;
        _tag             = adConfig.tag;
        _vpaidControls   = adConfig.vpaidControls;
        
        if (adConfig.rules)
        {
            _rules = [[WBRCTAdRules alloc] initWithAdRules:adConfig.rules];
        }
        
        if (adConfig.schedule && [adConfig.schedule count])
        {
            NSMutableArray<WBRCTAdBreak *> *schedule = [NSMutableArray<WBRCTAdBreak *> new];
            for (JWAdBreak *adBreak in adConfig.schedule)
            {
                [schedule addObject:[[WBRCTAdBreak alloc] initWithAdBreak:adBreak]];
            }
            _schedule = [schedule count] ? schedule : nil;
        }
        
        if (adConfig.googimaSettings)
        {
            _googimaSettings = [[WBRCTIMASettings alloc] initWithIMASettings:adConfig.googimaSettings];
        }
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSLog(@"[WBRCTAdConfig::get_data]");
    
    return @{
        @"adMessage":         self.adMessage
        , @"adVmap":          self.adVmap
        , @"client":          @(self.client)
        , @"googimaSettings": self.googimaSettings
        , @"rules":           self.rules
        , @"schedule":        self.schedule
        , @"skipMessage":     self.skipMessage
        , @"skipOffset":      @(self.skipOffset)
        , @"skipText":        self.skipText
        , @"tag":             self.tag
        , @"vpaidControls":   @(self.vpaidControls)
    };
}

- (NSData *) json
{
    NSLog(@"[WBRCTAdConfig::get_json]");
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWAdConfig *) adConfig
{
    NSLog(@"[WBRCTAdConfig::get_adConfig]");
    
    JWAdConfig *adConfig = [[JWAdConfig alloc] init];
    
    adConfig.adMessage       = self.adMessage;
    adConfig.adVmap          = self.adVmap;
    adConfig.client          = self.client;
    adConfig.googimaSettings = self.googimaSettings ? self.googimaSettings.imaSettings : nil;
    adConfig.rules           = self.rules           ? self.rules.adRules               : nil;
    adConfig.skipMessage     = self.skipMessage;
    adConfig.skipOffset      = self.skipOffset;
    adConfig.skipText        = self.skipText;
    adConfig.tag             = self.tag;
    adConfig.vpaidControls   = self.vpaidControls;
    
    NSMutableArray<JWAdBreak *> *schedule = [NSMutableArray<JWAdBreak *> new];
    for (WBRCTAdBreak *adBreak in self.schedule)
    {
        [schedule addObject:[adBreak adBreak]];
    }
    adConfig.schedule = [schedule count] ? schedule : nil;
    
    return adConfig;
}

@end
