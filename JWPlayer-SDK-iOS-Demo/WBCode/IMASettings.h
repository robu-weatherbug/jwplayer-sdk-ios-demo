//
//  IMASettings.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWAdConfig.h>

@interface IMASettings : NSObject

@property (nonatomic) BOOL autoPlayAdBreaks;
@property (nonatomic) BOOL disableNowPlayingInfo;
@property (nonatomic) BOOL enableBackgroundPlayback;
@property (nonatomic) BOOL enableDebugMode;
@property (nonatomic, copy) NSString *language;
@property (nonatomic) NSUInteger maxRedirects;
@property (nonatomic, copy) NSString *playerType;
@property (nonatomic, copy) NSString *playerVersion;
@property (nonatomic, copy) NSString *ppid;

@end
