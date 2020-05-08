//
//  WBRCTAdBreak.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWAdBreak.h>

@interface WBRCTAdBreak : NSObject

@property (nonatomic) BOOL isNonLinear;
@property (nonatomic, copy) NSString *offset;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSArray<NSString *> *tags;

- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithAdBreak:(JWAdBreak *) adBreak;

- (NSDictionary *) data;
- (NSData *) json;
- (JWAdBreak *) adBreak;

@end
