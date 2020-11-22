//
//  WBRCTJWPlayerView.h
//  react-native-jwplayer
//
//  Created by Rob Umberger on 3/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBRCTPlayerConfig.h"
#import "WBRCTVideoPlayList.h"
#import "WBRCTVideoItem.h"

#import <JWPlayer_iOS_SDK/JWPlayerController.h>

@interface WBRCTJWPlayerView : UIView

//- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher NS_DESIGNATED_INITIALIZER;

// Playback management
- (void) next;
- (void) play;
- (void) pause;
- (void) stop;
- (void) seek:(NSInteger) position;
- (CGFloat) getPosition;
- (CGFloat) getDuration;
@property (nonatomic) CGFloat volume;

// Player attributes
- (JWPlayerState) getCurrentState;
- (NSUInteger) getBuffer;
@property (nonatomic) BOOL controls;


// Player quality levels management
- (NSUInteger) getCurrentQuality;
- (NSArray *) getQualityLevels;

// Player playlist management
@property (nonatomic) NSInteger playlistIndex;

// Player full screen management
@property (nonatomic) BOOL fullscreen;


// Player config from JS side
@property (nonatomic, retain) WBRCTPlayerConfig *playerConfig;

@property (nonatomic, retain) JWConfig *playerConfigNative;

// Video playlist from JS side
@property (nonatomic, retain) WBRCTVideoPlayList *videoPlayList;


/*

// Playback event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerFirstFrame;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPlay;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPause;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerIdle;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerComplete;


// Buffer event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerBuffer;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerBufferChange;


// Playback Position event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerSeek;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerSeeked;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerTime;


// Controls event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerControls;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerDisplayClick;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerControlBarVisibilityChanged;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPlaybackRateChanged;


// Playlists event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPlaylist;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPlaylistItem;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerPlaylistComplete;


// Quality event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerLevels;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerLevelsChanged;


// Audio Track event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAudioTracks;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAudioTrackChanged;


// Captions event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerCaptionsList;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerCaptionsChanged;


// Related Overlay event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerRelatedOpen;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerRelatedClose;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerRelatedPlay;


// Advertising event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerBeforePlay;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerBeforeComplete;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdStarted;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdClick;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdSchedule;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdCompanions;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdRequest;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdImpression;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdBreakStart;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdBreakEnd;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdComplete;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdSkipped;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdTime;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdPause;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdPlay;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerAdError;


// Resize event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerFullscreen;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerFullscreenRequested;


// Setup event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerReady;
@property (nonatomic, copy) RCTDirectEventBlock onPlayerSetupError;


// Media error event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerError;


// Metadata event handlers from JS side
@property (nonatomic, copy) RCTDirectEventBlock onPlayerMeta;
*/

@end
