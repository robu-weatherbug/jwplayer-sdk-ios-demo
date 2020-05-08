//
//  WBRCTAdConfig.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWAdConfig.h>
#import "WBRCTAdBreak.h"
#import "WBRCTAdRules.h"
#import "WBRCTIMASettings.h"

@interface WBRCTAdConfig : NSObject

@property (nonatomic, copy) NSString *adMessage;
@property (nonatomic, copy) NSString *adVmap;
@property (nonatomic) JWAdClient client;
@property (nonatomic) WBRCTIMASettings *googimaSettings;
@property (nonatomic, retain) WBRCTAdRules *rules;
@property (nonatomic, copy) NSArray<WBRCTAdBreak *> *schedule;
@property (nonatomic, copy) NSString *skipMessage;
@property (nonatomic) NSInteger skipOffset;
@property (nonatomic, copy) NSString *skipText;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic) BOOL vpaidControls;


- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithAdConfig:(JWAdConfig *) adConfig;

- (NSDictionary *) data;
- (NSData *) json;
- (JWAdConfig *) adConfig;

@end
