//
//  WBRCTPlayerConfig.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 5/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTPlayerConfig.h"
#import "WBRCTVideoItem.h"
#import "WBRCTVideoPlayList.h"
#import "NSDictionary+Converters.h"


@interface WBRCTPlayerConfig ()
@property (nonatomic, retain, readwrite) JWConfig *jwConfig;
@end

@implementation WBRCTPlayerConfig

static const BOOL kAutoStart     = NO;
static const BOOL kControls      = YES;
static const BOOL kFullScreen    = NO;
static const BOOL kMuted         = YES;
static const BOOL kNextUpDisplay = YES;
static const int  kNextUpOffset  = -10;
static const int  kPlaylistIndex = 0;
static const BOOL kPreload       = YES;

- (instancetype)initWithData:(NSDictionary *) data
{
    NSLog(@"[WBRCTPlayerConfig::initWithData]");
    
    BOOL hasData = false;
    
    NSDictionary *advertising;
    NSNumber *autoStart;
    NSNumber *controls;
    NSNumber *fullScreen;
    NSNumber *muted;
    NSNumber *nextUpDisplay;
    NSNumber *nextUpOffset;
    NSNumber *playlistIndex;
    NSNumber *preload;
    NSArray *playlist;
    
    if (data != nil && [data count])
    {
        advertising   = [data parseDictionaryForKey:@"advertising"];
        autoStart     = [data parseBoolValueForKey:@"autoStart"];
        controls      = [data parseBoolValueForKey:@"controls"];
        fullScreen    = [data parseBoolValueForKey:@"fullScreen"];
        muted         = [data parseBoolValueForKey:@"muted"];
        nextUpDisplay = [data parseBoolValueForKey:@"nextUpDisplay"];
        nextUpOffset  = [data parseIntegerValueForKey:@"nextUpOffset"];
        playlistIndex = [data parseIntegerValueForKey:@"playlistIndex"];
        preload       = [data parseBoolValueForKey:@"preload"];
        
        playlist      = [data parseArrayForKey:@"playlist"];
        
        hasData = (advertising && [advertising count])
                || autoStart     != nil
                || controls      != nil
                || fullScreen    != nil
                || muted         != nil
                || nextUpDisplay != nil
                || nextUpOffset  != nil
                || playlistIndex != nil
                || preload       != nil
                || (playlist && [playlist count])
        ;
    }
    
    if ((self = [super init]) && hasData)
    {
        self.autoStart     = autoStart     != nil ? autoStart.boolValue        : kAutoStart;
        self.controls      = controls      != nil ? controls.boolValue         : kControls;
        self.fullScreen    = fullScreen    != nil ? fullScreen.boolValue       : kFullScreen;
        self.muted         = muted         != nil ? muted.boolValue            : kMuted;
        self.nextUpDisplay = nextUpDisplay != nil ? nextUpDisplay.boolValue    : kNextUpDisplay;
        self.nextUpOffset  = nextUpOffset  != nil ? nextUpOffset.integerValue  : kNextUpOffset;
        self.playlistIndex = playlistIndex != nil ? playlistIndex.integerValue : kPlaylistIndex;
        self.preload       = preload       != nil ? preload.boolValue          : kPreload;
        
        if (advertising && [advertising count])
        {
            self.advertising = [[WBRCTAdConfig alloc] initWithData:advertising];
        }
        
        if (playlist && [playlist count])
        {
            WBRCTVideoPlayList *videoPlaylist = [[WBRCTVideoPlayList alloc] initWithPlaylistItems:playlist];
            if (videoPlaylist && videoPlaylist.playlist && [videoPlaylist.playlist count])
            {
                self.playlist = [videoPlaylist.playlist copy];
            }
        }
    }
    else
    {
        self = WBRCTPlayerConfig.defaultConfig;
    }
    
    _jwConfig = [WBRCTPlayerConfig convertToJWConfig:self];
    
    return self;
}

- (instancetype)initWithJson:(id) json
{
    NSLog(@"[WBRCTPlayerConfig::initWithJson] JSON: %@", json);
    
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *jsonObject = [
                                NSJSONSerialization
                                JSONObjectWithData:jsonData
                                options:0
                                error:&error
                                ];
    
    if (!error)
    {
        self = [[WBRCTPlayerConfig alloc] initWithData:jsonObject];
    }
    else
    {
        NSLog(@"Error in parsing JSON");
    }
    
    return self;
}

- (instancetype)initWithConfig:(JWConfig *) config
{
    NSLog(@"[WBRCTPlayerConfig::initWithConfig]");
    
    if ((self = [super init]) && config)
    {
        self.autoStart     = config.autostart;
        self.controls      = config.controls;
        self.fullScreen    = kFullScreen;
        self.muted         = kMuted;
        self.nextUpDisplay = config.nextUpDisplay;
        self.nextUpOffset  = config.nextupOffset;
        self.playlistIndex = config.playlistIndex;
        self.preload       = config.preload;
        
        if (config.playlist && [config.playlist count])
        {
            WBRCTVideoPlayList *videoPlaylist = [[WBRCTVideoPlayList alloc] initWithPlaylistItems:config.playlist];
            if (videoPlaylist && videoPlaylist.playlist && [videoPlaylist.playlist count])
            {
                self.playlist = [videoPlaylist.playlist copy];
            }
        }
        
        if (config.advertising)
        {
            self.advertising = [[WBRCTAdConfig alloc] initWithAdConfig:config.advertising];
        }
    }
    
    _jwConfig = [WBRCTPlayerConfig convertToJWConfig:self];
    
    return self;
}

- (instancetype)initWithConfig:(JWConfig *) config andPlaylist:(NSArray<JWPlaylistItem *> *) playlist
{
    NSLog(@"[WBRCTPlayerConfig::initWithConfig:andPlaylist]");

    if ((self = [super init]) && config)
    {
        self.autoStart     = config.autostart;
        self.controls      = config.controls;
        self.fullScreen    = kFullScreen;
        self.muted         = kMuted;
        self.nextUpDisplay = config.nextUpDisplay;
        self.nextUpOffset  = config.nextupOffset;
        self.playlistIndex = config.playlistIndex;
        self.preload       = config.preload;
        
        if (playlist && [playlist count])
        {
            WBRCTVideoPlayList *videoPlaylist = [[WBRCTVideoPlayList alloc] initWithPlaylistItems:playlist];
            if (videoPlaylist && videoPlaylist.playlist && [videoPlaylist.playlist count])
            {
                self.playlist = [videoPlaylist.playlist copy];
            }
        }
        
        if (config.advertising)
        {
            self.advertising = [[WBRCTAdConfig alloc] initWithAdConfig:config.advertising];
        }
    }
    
    _jwConfig = [WBRCTPlayerConfig convertToJWConfig:self];
    
    return self;
}

- (instancetype)initWithConfig:(JWConfig *) config andPlayistItem:(JWPlaylistItem *) playistItem
{
    NSLog(@"[WBRCTPlayerConfig::initWithConfig:andPlaylistItem]");
    
    return [self initWithConfig:config andPlaylist:@[playistItem]];
}

+ (WBRCTPlayerConfig *) defaultConfig
{
    NSLog(@"[WBRCTPlayerConfig::get_defaultConfig]");
    
    static WBRCTPlayerConfig *defaultConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultConfig = [[WBRCTPlayerConfig alloc] init];
        defaultConfig.autoStart     = kAutoStart;
        defaultConfig.controls      = kControls;
        defaultConfig.fullScreen    = kFullScreen;
        defaultConfig.muted         = kMuted;
        defaultConfig.nextUpDisplay = kNextUpDisplay;
        defaultConfig.nextUpOffset  = kNextUpOffset;
        defaultConfig.playlistIndex = kPlaylistIndex;
        defaultConfig.preload       = kPreload;
    });
    
    /*
     WBRCTPlayerConfig *defaultConfig = [[WBRCTPlayerConfig alloc] init];
     defaultConfig.autoStart     = kAutoStart;
     defaultConfig.controls      = kControls;
     defaultConfig.fullScreen    = kFullScreen;
     defaultConfig.muted         = kMuted;
     defaultConfig.nextUpDisplay = kNextUpDisplay;
     defaultConfig.nextUpOffset  = kNextUpOffset;
     defaultConfig.playlistIndex = kPlaylistIndex;
     defaultConfig.preload       = kPreload;
     */
    
    return defaultConfig;
}

+ (JWConfig *)convertToJWConfig:(WBRCTPlayerConfig *) playerConfig
{
    NSLog(@"[WBRCTPlayerConfig::convertToJWConfig]");
    
    JWConfig *jwConfig = [[JWConfig alloc] init];
    
    if (playerConfig)
    {
        jwConfig.advertising   = playerConfig.advertising ? playerConfig.advertising.adConfig : nil;
        jwConfig.autostart     = playerConfig.autoStart;
        jwConfig.controls      = playerConfig.controls;
        jwConfig.nextUpDisplay = playerConfig.nextUpDisplay;
        jwConfig.nextupOffset  = playerConfig.nextUpOffset;
        jwConfig.preload       = playerConfig.preload  ? JWPreloadNone : JWPreloadAuto;
        // Within the playlist, the first index is 0. If the playlistIndex value is negative, the index starts counting from the end of the playlist.
        jwConfig.playlistIndex = playerConfig.playlistIndex;
        
        if (playerConfig.playlist && [playerConfig.playlist count])
        {
            WBRCTVideoPlayList *videoPlaylist = [[WBRCTVideoPlayList alloc] initWithPlaylist:playerConfig.playlist];
            [jwConfig setPlaylist:videoPlaylist.playListItems];
        }

    }
    else
    {
        jwConfig.autostart     = kAutoStart;
        jwConfig.controls      = kControls;
        jwConfig.nextUpDisplay = kNextUpDisplay;
        jwConfig.nextupOffset  = kNextUpOffset;
        jwConfig.preload       = kPreload ? JWPreloadNone : JWPreloadAuto;
    }
    
    return jwConfig;
}

@end
