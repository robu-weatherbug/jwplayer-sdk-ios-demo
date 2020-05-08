//
//  WBRCTAdRules.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWAdRules.h>

@interface WBRCTAdRules : NSObject

@property (nonatomic) NSUInteger startOn;
@property (nonatomic) NSUInteger frequency;
@property (nonatomic) NSUInteger timeBetweenAds;
@property (nonatomic) JWAdShown startOnSeek;

- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithAdRules:(JWAdRules *) adRules;

- (NSDictionary *) data;
- (NSData *) json;
- (JWAdRules *) adRules;

@end
