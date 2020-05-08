//
//  NSDictionary+Converters.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Converters)

- (NSNumber *) parseBoolValueForKey:(NSString *) key;
- (NSNumber *) parseBoolValueForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey;
- (NSDictionary *) parseDictionaryForKey:(NSString *) key;
- (NSDictionary *) parseDictionaryForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey;
- (NSString *) parseStringForKey:(NSString *) key;
- (NSString *) parseStringForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey;
- (NSNumber *) parseIntegerValueForKey:(NSString *) key;
- (NSNumber *) parseIntegerValueForKey:(NSString *) key withDefaultKey:(NSString *) defaultKey;
- (NSURL *) parseUrlForKey:(NSString *) key;
- (NSArray *) parseArrayForKey:(NSString *) key;
- (NSData *) parseDataForKey:(NSString *) key;

@end
