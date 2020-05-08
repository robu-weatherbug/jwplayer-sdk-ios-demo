//
//  WBRCTPlayerConfig.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWConfig.h>
#import "WBRCTAdConfig.h"

@interface WBRCTPlayerConfig : NSObject

@property (nonatomic, retain) WBRCTAdConfig *advertising;
@property (nonatomic) BOOL autoStart;
@property (nonatomic) BOOL controls;
@property (nonatomic) BOOL fullScreen;
@property (nonatomic) BOOL muted;
@property (nonatomic) BOOL nextUpDisplay;
@property (nonatomic, assign) NSInteger nextUpOffset;
@property (nonatomic, assign) NSInteger playlistIndex;
@property (nonatomic) BOOL preload;

@property (nonatomic, retain, readonly) JWConfig *jwConfig;

- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithConfig:(JWConfig *) config;

+ (WBRCTPlayerConfig *) defaultConfig;

@end
