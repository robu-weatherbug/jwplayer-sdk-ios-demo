//
//  NSDictionary+Converters.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "NSDictionary+Converters.h"

@interface NSDictionary (Converters_Private)
- (BOOL) _containsValueForKey:(NSString*)key;
@end

@implementation NSDictionary (Converters)

#pragma mark -
#pragma mark Public Methods

- (NSNumber *) parseBoolValueForKey:(NSString *) key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [NSNumber numberWithBool:[[self objectForKey:key] boolValue]];
}

-(NSNumber *) parseBoolValueForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey
{
    NSNumber *number = [self parseBoolValueForKey:key];
    if (!number)
    {
        number = [self parseBoolValueForKey:defaultKey];
    }
    
    return number;
}

- (NSDictionary *) parseDictionaryForKey:(NSString *) key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [self objectForKey:key];
}

- (NSDictionary *) parseDictionaryForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey
{
    NSDictionary *dictionary = [self parseDictionaryForKey:key];
    if(!dictionary)
    {
        dictionary = [self parseDictionaryForKey:defaultKey];
    }
    
    return dictionary;
}

- (NSString *) parseStringForKey:(NSString *) key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [self objectForKey:key];
}

- (NSString *) parseStringForKey:(NSString *)key withDefaultKey:(NSString *) defaultKey
{
    NSString *value = [self parseStringForKey:key];
    if(!value)
    {
        value = [self parseStringForKey:defaultKey];
    }
    
    return value;
}

- (NSNumber*) parseIntegerValueForKey:(NSString*)key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [NSNumber numberWithInteger:[[self objectForKey:key] integerValue]];
}

- (NSNumber *) parseIntegerValueForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey
{
    NSNumber *value = [self parseIntegerValueForKey:key];
    if(!value)
    {
        value = [self parseIntegerValueForKey:defaultKey];
    }
    
    return value;
}

- (NSURL *) parseUrlForKey:(NSString *) key
{
    NSURL *value = nil;
    NSString *url = [self parseStringForKey:key];
    
    if (url != nil)
    {
        value = [NSURL URLWithString:url];
    }
    
    return value;
}

- (NSArray *) parseArrayForKey:(NSString *) key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [self objectForKey:key];
}

- (NSData *) parseDataForKey:(NSString *) key
{
    if(![self _containsValueForKey:key])
    {
        return nil;
    }
    
    return [NSKeyedArchiver archivedDataWithRootObject:[self objectForKey:key]];
}

#pragma mark -
#pragma mark Private Methods

- (BOOL) _containsValueForKey:(NSString *) key
{
    id value = [self objectForKey:key];
    return value != nil && value != [NSNull null];
}

@end
