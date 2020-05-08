//
//  WBRCTMediaSource.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JWPlayer_iOS_SDK/JWSource.h>

@interface WBRCTMediaSource : NSObject

@property (nonatomic, copy) NSString *file;
@property (nonatomic) BOOL isDefaultQuality;
@property (nonatomic, copy) NSString *qualityLabel;

- (instancetype)initWithData:(NSDictionary *) data;
- (instancetype)initWithJson:(id) json;
- (instancetype)initWithSource:(JWSource *) source;

- (NSDictionary *) data;
- (NSData *) json;
- (JWSource *) source;

@end
