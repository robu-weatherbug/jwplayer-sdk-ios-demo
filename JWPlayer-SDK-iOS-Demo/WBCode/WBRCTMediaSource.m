//
//  WBRCTMediaSource.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTMediaSource.h"
#import "NSDictionary+Converters.h"

@implementation WBRCTMediaSource

- (instancetype)initWithData:(NSDictionary *) data
{
    BOOL hasData = false;
    
    NSString *file;
    NSString *qualityLabel;
    NSNumber *isDefaultQuality;
    
    if (data != nil && [data count])
    {
        file             = [data parseStringForKey:@"file"];
        qualityLabel     = [data parseStringForKey:@"qualityLabel"];
        isDefaultQuality = [data parseBoolValueForKey:@"isDefaultQuality"];
        
        hasData = file || qualityLabel || isDefaultQuality != nil;
    }
    
    if (hasData && (self = [super init]))
    {
        self.file         = file;
        self.qualityLabel = qualityLabel;
        
        if (isDefaultQuality != nil)
        {
            self.isDefaultQuality = isDefaultQuality.boolValue;
        }
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

- (instancetype)initWithSource:(JWSource *) source
{
    BOOL hasData = source && source.file && [source.file length];
    
    if (hasData && (self = [super init]))
    {
        self.file             = source.file;
        self.qualityLabel     = source.label;
        self.isDefaultQuality = source.defaultQuality;
    }
    
    return self;
}

- (NSDictionary *) data
{
    return @{
             @"file": self.file
             , @"qualityLabel": self.qualityLabel
             , @"isDefaultQuality": @(self.isDefaultQuality)
            };
}

- (NSData *) json
{
    return [NSKeyedArchiver archivedDataWithRootObject:[self data]];
}

- (JWSource *) source
{
    return [[JWSource alloc] initWithFile:self.file label:self.qualityLabel isDefault:self.isDefaultQuality];
}

@end
