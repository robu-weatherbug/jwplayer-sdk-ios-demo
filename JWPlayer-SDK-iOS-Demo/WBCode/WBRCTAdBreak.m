//
//  WBRCTAdBreak.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTAdBreak.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTAdBreak

- (instancetype)initWithData:(NSDictionary *) data
{
    NSLog(@"[WBRCTAdBreak::initWithData]");
    
    BOOL hasData = NO;
    
    NSNumber *isNonLinear;
    NSString *offset;
    NSString *tag;
    NSArray<NSString *> *tags;
    
    if (data && [data count])
    {
        isNonLinear = [data parseBoolValueForKey:@"isNonLinear"];
        offset      = [data parseStringForKey:@"offset"];
        tag         = [data parseStringForKey:@"tag"];
        tags        = [data parseArrayForKey:@"tags"];
        
        hasData = isNonLinear != nil || offset || tag || tags;
    }
    
    if ((self = [super init]) && hasData)
    {
        _isNonLinear = (isNonLinear != nil) ? isNonLinear.boolValue : NO;
        _offset      = offset;
        _tag         = tag;
        _tags        = (tags && [tags count]) ? tags : nil;
    }
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTAdBreak::initWithJson] JSON: %@", json);
    
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
        NSLog(@"[WBRCTAdBreak::initWithJson] Error in parsing JSON. %@", error);
    }
    else
    {
        self = [self initWithData:jsonObject];
    }
    
    return self;
}

- (instancetype)initWithAdBreak:(JWAdBreak *) adBreak
{
    NSLog(@"[WBRCTAdBreak::initWithAdBreak]");
    
    BOOL hasTags = adBreak && ((adBreak.tag && [adBreak.tag length]) || (adBreak.tags && [adBreak.tags count]));
    BOOL hasData = hasTags && adBreak.offset && [adBreak.offset length];
    
    if ((self = [super init]) && hasData)
    {
        _isNonLinear = adBreak.type == JWAdTypeNonlinear;
        _offset      = adBreak.offset;
        _tag         = adBreak.tag;
        _tags        = adBreak.tags;
    }
    
    return self;
}

- (NSDictionary *) data
{
    NSLog(@"[WBRCTAdBreak::get_data]");
    
    return @{
             @"isNonLinear": @(self.isNonLinear)
             , @"offset":    self.offset ? self.offset : @""
             , @"tag":       self.tag    ? self.tag    : @""
             , @"tags":      self.tags   ? self.tags   : @[@""]
    };
}

- (NSData *) json
{
    NSLog(@"[WBRCTAdBreak::get_json]");
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWAdBreak *) adBreak
{
    NSLog(@"[WBRCTAdBreak::get_adBreak]");
    
    NSArray *waterfallTags = self.tags != nil ? self.tags : self.tag ? @[self.tag] : @[];
    JWAdBreak *adBreak     = [waterfallTags count]
                           ? [JWAdBreak adBreakWithTags:waterfallTags offset:self.offset nonLinear:self.isNonLinear]
                           : nil;
    return adBreak;
}
@end
