//
//  WBRCTJWPlayerView.m
//  react-native-jwplayer
//
//  Created by Rob Umberger on 3/3/19.
//  Copyright © 2019 WeatherBug. All rights reserved.
//

#import "WBRCTJWPlayerView.h"
#import "NSDictionary+Converters.h"
/*
#import "RCTConvert+JWPlayerEnums.h"
#import <React/RCTUtils.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTLog.h>
#import <React/RCTAutoInsetsProtocol.h>
#import <React/UIView+React.h>
#import <React/RCTConvert.h>
*/
#import <JWPlayer_iOS_SDK/JWPlayerDelegate.h>
#import <JWPlayer_iOS_SDK/JWPlayerController.h>
#import <JWPlayer_iOS_SDK/JWEvent.h>
#import <JWPlayer_iOS_SDK/JWAdConfig.h>


@interface WBRCTJWPlayerView () <JWPlayerDelegate> { }

@property (nonatomic, strong) JWPlayerController *player;

@end


@implementation WBRCTJWPlayerView

static const CGFloat kDefaultDuration = 0.0f;
static const CGFloat kDefaultPosition = 0.0f;
static const CGFloat kDefaultVolume   = 0.0f;

@synthesize playerConfig  = _playerConfig;
@synthesize videoPlayList = _videoPlayList;
@synthesize volume        = _volume;
@synthesize controls      = _controls;
@synthesize fullscreen    = _fullscreen;
@synthesize playlistIndex = _playlistIndex;


@synthesize playerConfigNative  = _playerConfigNative;
@synthesize videoPlayListNative  = _videoPlayListNative;

@synthesize delegate      = _delegate;
@synthesize onFirstFrame  = _onFirstFrame;


/*
- (instancetype) initWithEventDispatcher:(RCTEventDispatcher *) eventDispatcher
{
    NSLog(@"[WBRCTJWPlayerView::initWithEventDispatcher]");
    
    if ((self = [super initWithFrame:CGRectZero]))
    {
        _eventDispatcher = eventDispatcher;
    }
    
    return self;
}
*/

/*
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView *playerView = self.player.view;
    [self.playerContainerView addSubview:playerView];
    [playerView constrainToSuperview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.playerContainerView addSubview:jwPlayerView];
}
*/

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    return self;
}

- (void)dealloc
{
    self.playerConfig = nil;
    self.videoPlayList = nil;
    self.playerConfigNative = nil;
    self.videoPlayListNative = nil;
    self.delegate = nil;
    self.onFirstFrame = nil;
    self.player = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

#pragma mark - JWPlayer playback management
- (void) next
{
    NSLog(@"[WBRCTJWPlayerView::next]");
    
    if (_player)
    {
        [_player next];
    }
}

- (void) play
{
    NSLog(@"[WBRCTJWPlayerView::play]");
    
    if (_player)
    {
        [_player play];
    }
}

- (void) pause
{
    NSLog(@"[WBRCTJWPlayerView::pause]");
    
    if (_player)
    {
        [_player pause];
    }
}

- (void) stop
{
    NSLog(@"[WBRCTJWPlayerView::stop]");
    
    if (_player)
    {
        [_player stop];
    }
}

- (void) seek:(NSInteger) position
{
    NSLog(@"[WBRCTJWPlayerView::seek] Position: %ld", (long)position);
    
    if (   _player
        && _player.position != position
        )
    {
        [_player seek:position];
    }
}

- (CGFloat) getPosition
{
    NSLog(@"[WBRCTJWPlayerView::getPosition]");
    
    CGFloat val = kDefaultPosition;
    
    if (_player)
    {
        val = _player.position;
    }
    
    return val;
}

- (CGFloat) getDuration
{
    NSLog(@"[WBRCTJWPlayerView::getDuration]");
    
    CGFloat val = kDefaultDuration;
    
    if (_player)
    {
        val = _player.duration;
    }
    
    return val;
}

- (CGFloat) getVolume
{
    NSLog(@"[WBRCTJWPlayerView::getVolume]");
    
    CGFloat val = kDefaultVolume;
    
    if (_player)
    {
        val = _player.volume;
    }
    
    return val;
}

- (void) setVolume:(CGFloat) volume
{
    NSLog(@"[WBRCTJWPlayerView::setVolume] Volume: %f", volume);
    
    _volume = volume;
    
    if (   _player
        && _player.volume != _volume
        )
    {
        _player.volume = _volume;
    }
}



#pragma mark - JWPlayer player attributes
- (JWPlayerState) getCurrentState
{
    NSLog(@"[WBRCTJWPlayerView::getCurrentState]");
    
    int val = JWPlayerStatePlaying;
    
    if (_player)
    {
        val = (int)_player.state;
    }
    
    return val;
}

- (NSUInteger) getBuffer
{
    NSLog(@"[WBRCTJWPlayerView::getBuffer]");
    
    NSUInteger val = 0;
    
    if (_player)
    {
        val = _player.buffer;
    }
    
    return val;
}

- (BOOL) getControls
{
    NSLog(@"[WBRCTJWPlayerView::getControls]");
    
    BOOL val = NO;
    
    if (_player)
    {
        val = _player.controls;
    }
    
    return val;
}

- (void) setControls:(BOOL) controls
{
    NSLog(@"[WBRCTJWPlayerView::setControls] Controls: %@", controls ? @"YES" : @"NO");
    
    _controls = controls;
    
    if (   _player
        && _player.controls != _controls
        )
    {
        _player.controls = _controls;
    }
}

#pragma mark - JWPlayer quality levels
- (NSUInteger) getCurrentQuality
{
    NSLog(@"[WBRCTJWPlayerView::getCurrentQuality]");
    
    NSUInteger val = kDefaultPosition;
    
    if (_player)
    {
        val = _player.currentQuality;
    }
    
    return val;
}

- (NSArray *) getQualityLevels
{
    NSLog(@"[WBRCTJWPlayerView::getQualityLevels]");
    
    NSArray *val = nil;
    
    if (_player)
    {
        val = _player.qualityLevels;
    }
    
    return val;
}


#pragma mark - JWPlayer play list management
- (NSInteger) getPlaylistIndex
{
    NSLog(@"[WBRCTJWPlayerView::getPlaylistIndex]");
    
    NSInteger val = kDefaultPosition;
    
    if (_player)
    {
        val = _player.playlistIndex;
    }
    
    return val;
}

- (void) setPlaylistIndex:(NSInteger) playlistIndex
{
    NSLog(@"[WBRCTJWPlayerView::setPlaylistIndex] Playlist Index: %ld", (long)playlistIndex);
    
    if (_playlistIndex != playlistIndex)
    {
        _playlistIndex = playlistIndex;
    }
    
    if (   _player
        && _player.playlistIndex != _playlistIndex
        )
    {
        _player.playlistIndex = _playlistIndex;
    }
}


#pragma mark - JWPlayer full screen management
- (BOOL) getFullscreen
{
    NSLog(@"[WBRCTJWPlayerView::getFullscreen]");
    
    BOOL val = NO;
    
    if (_player)
    {
        val = _player.fullscreen;
    }
    
    return val;
}

- (void) setFullscreen:(BOOL) fullscreen
{
    NSLog(@"[WBRCTJWPlayerView::setFullscreen] Fullscreen: %@", fullscreen ? @"YES" : @"NO");
    
    _fullscreen = fullscreen;
    
    if (   _player
        && _fullscreen != fullscreen
        )
    {
        _player.fullscreen = _fullscreen;
    }
}

#pragma mark - JWPlayer player configuration
- (void) setPlayerConfig: (WBRCTPlayerConfig *)playerConfig
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::setPlayerConfig] SDK Version: %@", JWPlayerController.SDKVersion);
    //#endif
    
    _playerConfig = playerConfig;
    
    /*
     if (_player)
     {
     _player = nil;
     }
     */
    
    if (_playerConfig)
    {
        //_player = [[JWPlayerController alloc] initWithConfig:_playerConfig.jwConfig delegate:self];
        [self configurePlayer];
        //_player.openSafariOnAdClick = YES;
        
        //[self setUpVideos];
        //[self addSubview:_player.view];
        /*if (_playerConfig.muted)
         {
         self.volume = kDefaultVolume;
         }
         
         if (_playlistIndex != _playerConfig.playlistIndex)
         {
         _playlistIndex = _playerConfig.playlistIndex;
         }*/
        
        //#ifdef DEBUG
        NSLog(@"[WBRCTJWPlayerView::setPlayerConfig] SDK Version: %@, Player Version: %@, Player Edition: %@, Current Playlist Index: %ld, Playlist Start Index: %ld, Config StartOn Index: %ld"
              , JWPlayerController.SDKVersion
              , _player.playerVersion
              , _player.playerEdition
              , (long)_player.playlistIndex
              , (long)_player.config.playlistIndex
              , (long)_player.config.advertising.rules.startOn
              );
        //#endif
    }
}

- (void) setPlayerConfigNative: (JWConfig *)playerConfig
{
    NSLog(@"[WBRCTJWPlayerView::setPlayerConfigNative] SDK Version: %@", JWPlayerController.SDKVersion);
    
    if (_player)
    {
        if (_player && _player.view && _player.view.superview)
        {
            [_player.view removeFromSuperview];
        }
        
        _player = nil;
    }
    
    /*
     if (   playerConfig.advertising
     && playerConfig.advertising.schedule
     && [playerConfig.advertising.schedule count]
     && playerConfig.playlist
     && [playerConfig.playlist count]
     )
     {
     for (JWPlaylistItem *playlistItem in playerConfig.playlist)
     {
     playlistItem.adSchedule = [playerConfig.advertising.schedule copy];
     }
     }
     */
    
    _player = [[JWPlayerController alloc] initWithConfig:playerConfig delegate:self];
    _player.openSafariOnAdClick = YES;
    
    [self addSubview:_player.view];
    if (_playerConfig.muted)
    {
        self.volume = kDefaultVolume;
    }
    
    NSLog(@"[WBRCTJWPlayerView::setPlayerConfigNative] SDK Version: %@, Player Version: %@, Player Edition: %@, Current Playlist Index: %ld, Playlist Start Index: %ld, Config StartOn Index: %ld"
          , JWPlayerController.SDKVersion
          , _player.playerVersion
          , _player.playerEdition
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          );
}

- (void) setVideoPlayList: (WBRCTVideoPlayList *)videoPlayList
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::setVideoPlayList] Playlist Length: %ld", (long)videoPlayList.playListItems.count);
    //#endif
    
    [_player.config setPlaylist:videoPlayList.playListItems];
    
    //_videoPlayList = videoPlayList;
    //[self configurePlayer];
    
    //[self setUpVideos];
}

- (void) setVideoPlayListNative: (NSArray <JWPlaylistItem *> *)videoPlayListNative
{
    
}

/*
- (void) setUpVideos
{
    if (   _player
        && self.videoPlayList
        && self.videoPlayList.videoItems
        && self.videoPlayList.videoItems.count
        )
    {
        if (self.videoPlayList.videoItems.count == 1)
        {
            WBRCTVideoItem *videoItem = self.videoPlayList.videoItems[0];
            NSMutableArray *sources   = [NSMutableArray new];
            
            for (WBRCTMediaSource *source in videoItem.mediaSources)
            {
                JWSource *jwSource = [JWSource sourceWithFile:source.file label:source.qualityLabel isDefault:source.isDefaultQuality];
                [sources addObject:jwSource];
            }
            
            _player.config.desc    = videoItem.desc;
            _player.config.file    = videoItem.file;
            _player.config.image   = [videoItem.posterImageUrl absoluteString];
            _player.config.mediaId = videoItem.mediaId;
            _player.config.sources = sources;
            _player.config.title   = videoItem.title;
            
            if ( videoItem.adSchedule
                && [videoItem.adSchedule count]
                )
            {
                JWAdConfig *adConfig = [JWAdConfig new];
                adConfig.skipText    = @"Skip";
                adConfig.skipOffset  = _player.config.advertising.skipOffset?_player.config.advertising.skipOffset:5;
                adConfig.client      = _player.config.advertising.client?_player.config.advertising.client:JWAdClientVast;
                
                NSMutableArray *adSchedule = [NSMutableArray new];
                for (WBRCTAdBreak *ad in videoItem.adSchedule)
                {
                    [adSchedule addObject:[ad adBreak]];
                }
                
                adConfig.schedule          = adSchedule;
                _player.config.advertising = adConfig;
            }
        }
        else
        {
            NSMutableArray *playListItems = [NSMutableArray new];
            for (WBRCTVideoItem *videoItem in self.videoPlayList.videoItems)
            {
                JWPlaylistItem *playlistItem = [JWPlaylistItem new];
                NSMutableArray *sources = [NSMutableArray new];
                
                for (WBRCTMediaSource *source in videoItem.mediaSources)
                {
                    JWSource *jwSource = [JWSource sourceWithFile:source.file label:source.qualityLabel isDefault:source.isDefaultQuality];
                    [sources addObject:jwSource];
                }
                
                playlistItem.desc    = videoItem.desc;
                playlistItem.file    = videoItem.file;
                playlistItem.image   = [videoItem.posterImageUrl absoluteString];
                playlistItem.mediaId = videoItem.mediaId;
                playlistItem.sources = sources;
                playlistItem.title   = videoItem.title;
                //NOTE:- check this out for adding ad tag variables https://support.jwplayer.com/articles/ad-tag-targeting-macro-reference
                if (    videoItem.adSchedule
                    && [videoItem.adSchedule count]
                    )
                {
                    NSMutableArray *adSchedule = [NSMutableArray new];
                    for (WBRCTAdBreak *ad in videoItem.adSchedule)
                    {
                        [adSchedule addObject:[ad adBreak]];
                    }
                    
                    playlistItem.adSchedule = adSchedule;
                }
                
                [playListItems addObject:playlistItem];
            }
            
            [_player.config setPlaylist:playListItems];
        }
    }
}
*/

- (void) layoutSubviews
{
    NSLog(@"[WBRCTJWPlayerView::layoutSubviews]");
    
    [super layoutSubviews];
    if (_player && _player.view)
    {
        _player.view.frame = self.frame;
    }
}

- (void) removeFromSuperview
{
    NSLog(@"[WBRCTJWPlayerView::removeFromSuperview]");
    
    //_eventDispatcher = nil;
    _videoPlayList = nil;
    _playerConfig = nil;
    
    [super removeFromSuperview];
}


#pragma mark - JWPlayer playback event handlers
- (void) onFirstFrame:(JWEvent<JWFirstFrameEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onFirstFrame]");
    //@property(nonatomic, assign) SEL onFirstFrame;
    if([self.delegate respondsToSelector:@selector(onFirstFrame:)])
    {
        [self.delegate performSelector:@selector(onFirstFrame:) withObject:@(_player.playlistIndex)];
    }
}

- (void) onPlay:(JWEvent<JWStateChangeEvent> *)event;
{
    NSLog(@"[WBRCTJWPlayerView::onPlay]");
}

- (void) onPause:(JWEvent<JWStateChangeEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onPause]");
}

- (void) onIdle:(JWEvent<JWStateChangeEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onIdle]");
}

- (void) onComplete
{
    NSLog(@"[WBRCTJWPlayerView::onComplete]");
}


#pragma mark - JWPlayer buffer event handlers
- (void) onBuffer:(JWEvent<JWBufferEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onBuffer]");
}

- (void) onBufferChange:(JWEvent<JWBufferChangeEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onBufferChange]");
}


#pragma mark - JWPlayer playback position event handlers
- (void) onSeek:(JWEvent<JWSeekEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onSeek]");
}
- (void) onSeeked
{
    NSLog(@"[WBRCTJWPlayerView::onSeeked]");
}
- (void) onTime:(JWEvent<JWTimeEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onTime]");
}


#pragma mark - JWPlayer controls event handlers
- (void) onControls:(JWEvent<JWControlsEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onControls]");
}
- (void) onDisplayClick
{
    NSLog(@"[WBRCTJWPlayerView::onDisplayClick]");
}
- (void) onControlBarVisible:(JWEvent<JWControlsEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onControlBarVisible]");
}
- (void) onPlaybackRateChanged:(JWEvent<JWPlaybackRateEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onPlaybackRateChanged]");
}


#pragma mark - JWPlayer playlists event handlers
- (void) onPlaylist:(JWEvent<JWPlaylistEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onPlaylist]");
}
- (void) onPlaylistItem:(JWEvent<JWPlaylistItemEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onPlaylistItem] Player Playlist Index: %ld; Event Playlist Index: %ld", _player.playlistIndex, event.index);
}
- (void) onPlaylistComplete
{
    NSLog(@"[WBRCTJWPlayerView::onPlaylistComplete]");
}


#pragma mark - JWPlayer quality event handlers
- (void) onLevels:(JWEvent<JWLevelsEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onLevels]");
}
- (void) onLevelsChanged:(JWEvent<JWLevelsChangedEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onLevelsChanged]");
}


#pragma mark - JWPlayer audio track event handlers
- (void) onAudioTracks:(JWEvent<JWLevelsEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onAudioTracks]");
}
- (void) onAudioTrackChanged:(JWEvent<JWTrackChangedEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onAudioTrackChanged]");
}


#pragma mark - JWPlayer captions event handlers
- (void) onCaptionsList:(JWEvent<JWCaptionsListEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onCaptionsList]");
}
- (void) onCaptionsChanged:(JWEvent<JWTrackChangedEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onCaptionsChanged]");
}


#pragma mark - JWPlayer related overlay event handlers
- (void) onRelatedOpen:(JWRelatedEvent<JWRelatedOpenEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onRelatedOpen]");
}
- (void) onRelatedClose:(JWRelatedEvent<JWRelatedInteractionEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onRelatedClose]");
}
- (void) onRelatedPlay:(JWRelatedEvent<JWRelatedPlayEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onRelatedPlay]");
}


#pragma mark - JWPlayer advertising event handlers
-(NSString *) getAdClient:(JWAdClient) client
{
    NSLog(@"[WBRCTJWPlayerView::getAdClient]");
    
    NSString *adClientType = @"";
    switch (client) {
        case JWAdClientVast:
            adClientType = @"vast";
            break;
        case JWAdClientGoogima:
            adClientType = @"ima";
            break;
        case JWAdClientFreewheel:
            adClientType = @"fw";
            break;
        case JWAdClientGoogimaDAI:
            adClientType = @"ima_dai";
            break;
        default:
            break;
    }
    return adClientType;
}


- (void) onBeforePlay
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onBeforePlay]");
    //#endif
}
- (void) onBeforeComplete
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onBeforeComplete]");
    //#endif
}
- (void) onAdStarted:(JWAdEvent<JWAdDetailEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdStarted] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdClick:(JWAdEvent<JWAdDetailEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdClick] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdSchedule:(JWAdEvent<JWAdScheduleEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdSchedule] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, AdBreak Count: %ld, Client: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , (long)event.adBreaks.count
          , [self getAdClient:event.client]
          , event.tag
          );
    //#endif
    
    [self logCurrentPlaylistItems];
    [self logConfiguredPlaylistItems];
}
- (void) onAdCompanions:(JWAdEvent<JWAdCompanionsEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdCompanions] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Companions Count: %ld, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , (long)event.companions.count
          , event.tag
          );
    //#endif
}
- (void) onAdRequest:(JWAdEvent<JWAdRequestEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdRequest] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Position: %@, Offset: %@, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , event.adPosition
          , event.offset
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdImpression:(JWAdEvent<JWAdImpressionEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdImpression] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Position: %@, AdSystem: %@, Client: %@, Creative Type: %@, VAST Version: %@, Media File: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , event.adPosition
          , event.adSystem
          , [self getAdClient:event.client]
          , event.creativeType
          , [NSNumber numberWithFloat:event.vastVersion]
          , event.mediaFile
          , event.tag
          );
    //#endif
}
- (void) onAdBreakStart:(JWAdEvent<JWAdBreakEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdBreakStart] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Position: %@, Client: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , event.adPosition
          , [self getAdClient:event.client]
          , event.tag
          );
    //#endif
}
- (void) onAdBreakEnd:(JWAdEvent<JWAdBreakEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdBreakEnd] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Position: %@, Client: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , event.adPosition
          , [self getAdClient:event.client]
          , event.tag
          );
    //#endif
}
- (void) onAdComplete:(JWAdEvent<JWAdDetailEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdComplete] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdSkipped:(JWAdEvent<JWAdDetailEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdSkipped] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdTime:(JWAdEvent<JWAdTimeEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onAdTime]");
}
- (void) onAdPause:(JWAdEvent<JWAdStateChangeEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdPause] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdPlay:(JWAdEvent<JWAdStateChangeEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdPlay] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Client: %@, Creative Type: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [self getAdClient:event.client]
          , event.creativeType
          , event.tag
          );
    //#endif
}
- (void) onAdError:(JWAdEvent<JWErrorEvent> *)event
{
    //#ifdef DEBUG
    NSLog(@"[WBRCTJWPlayerView::onAdError] Current Index: %ld, Config Start Index: %ld, Advertising StartOn Index: %ld, Error Code: %@, Ad Error Code: %@, Error Description: %@, Tag: %@"
          , (long)_player.playlistIndex
          , (long)_player.config.playlistIndex
          , (long)_player.config.advertising.rules.startOn
          , [event.error.userInfo parseIntegerValueForKey:@"adErrorCode"]
          , @(event.error.code)
          , event.error.localizedDescription
          , event.tag
          );
    //#endif
}


#pragma mark - JWPlayer resize event handlers
- (void) onFullscreen:(JWEvent<JWFullscreenEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onFullscreen]");
}
- (void) onFullscreenRequested:(JWEvent<JWFullscreenEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onFullscreenRequested]");
}


#pragma mark - JWPlayer setup event handlers
- (void) onReady:(JWEvent<JWReadyEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onReady] JWReadyEvent: %@", event);
}

- (void) onSetupError:(JWEvent<JWErrorEvent> *)event;
{
    NSLog(@"[WBRCTJWPlayerView::onSetupError] JWErrorEvent: %@", event);
}


#pragma mark - JWPlayer media error event handlers
- (void) onError:(JWEvent<JWErrorEvent> *)event;
{
    NSLog(@"[WBRCTJWPlayerView::onError] JWErrorEvent: %@", event);
}


#pragma mark - JWPlayer metadata event handlers
- (void) onMeta:(JWEvent<JWMetaEvent> *)event
{
    NSLog(@"[WBRCTJWPlayerView::onMeta]");
}



- (void) logCurrentPlaylistItems
{
    NSData *jsonData = nil;
    NSDictionary *playlistData = [self getPlaylistItems:_player.getPlaylist];
    
#ifdef DEBUG
    jsonData = [NSJSONSerialization dataWithJSONObject:playlistData options:NSJSONWritingWithoutEscapingSlashes error:nil];
#else
    jsonData = [NSJSONSerialization dataWithJSONObject:playlistData options:NSJSONWritingPrettyPrinted error:nil];
#endif
    
    NSLog(@"[WBRCTJWPlayerView::logCurrentPlaylistItems] %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (void) logConfiguredPlaylistItems
{
    NSData *jsonData = nil;
    NSDictionary *playlistData = [self getPlaylistItems:_player.config.playlist];
    
#ifdef DEBUG
    jsonData = [NSJSONSerialization dataWithJSONObject:playlistData options:NSJSONWritingWithoutEscapingSlashes error:nil];
#else
    jsonData = [NSJSONSerialization dataWithJSONObject:playlistData options:NSJSONWritingPrettyPrinted error:nil];
#endif
    
    NSLog(@"[WBRCTJWPlayerView::logConfiguredPlaylistItems] %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

/*
 #ifdef DEBUG
 - (NSString *) serializePlaylistItems:(NSArray <JWPlaylistItem *> *)playlist
 {
 NSDictionary *playlistData = [self getPlaylistItems:playlist];
 NSError *writeError;
 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:playlistData options:NSJSONWritingWithoutEscapingSlashes error:&writeError];
 return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 }
 #endif
 */

- (NSDictionary *) getPlaylistItems:(NSArray <JWPlaylistItem *> *)playlist
{
    NSLog(@"[WBRCTJWPlayerView::getPlaylistItems] Playlist Length: %ld", (long)(playlist && playlist.count ? [playlist count] : 0));
    
    NSDictionary *playlistData;
    
    if (playlist && [playlist count])
    {
        NSMutableArray<NSDictionary *> *playlistItems = [NSMutableArray<NSDictionary *> new];
        for (JWPlaylistItem *playlistItem in playlist)
        {
            NSMutableArray<NSDictionary *> *mediaSources = [NSMutableArray<NSDictionary *> new];
            for (JWSource *mediaSource in playlistItem.sources)
            {
                NSDictionary *mediaSourceData = @{
                    @"file":               mediaSource.file  ? mediaSource.file  : @""
                    , @"qualityLabel":     mediaSource.label ? mediaSource.label : @""
                    , @"isDefaultQuality": @(mediaSource.defaultQuality)
                };
                [mediaSources addObject:mediaSourceData];
            }
            
            NSMutableArray<NSDictionary *> *adBreaks = [NSMutableArray<NSDictionary *> new];
            for (JWAdBreak *adSchedule in playlistItem.adSchedule)
            {
                NSDictionary *adScheduleData = @{
                    @"isNonLinear": adSchedule.type == JWAdTypeNonlinear ? @"YES" : @"NO"
                    , @"offset":    adSchedule.offset                    ? adSchedule.offset : @""
                    , @"tag":       adSchedule.tag                       ? adSchedule.tag : @""
                    , @"tags":      adSchedule.tags                      ? adSchedule.tags : @[@""]
                    , @"vmapInfo":  adSchedule.vmapInfo                  ? adSchedule.vmapInfo : @[@""]
                };
                [adBreaks addObject:adScheduleData];
            }
            
            NSMutableDictionary *playlistItemData = [@{
                @"description":      playlistItem.desc    ? playlistItem.desc    : @""
                , @"file":           playlistItem.file    ? playlistItem.file    : @""
                , @"mediaId":        playlistItem.mediaId ? playlistItem.mediaId : @""
                , @"posterImageUrl": playlistItem.image   ? playlistItem.image   : @""
                , @"title":          playlistItem.title   ? playlistItem.title   : @""
            } mutableCopy];
            
            if ([adBreaks count])
            {
                [playlistItemData setObject:adBreaks forKey:@"adSchedule"];
            }
            
            if ([mediaSources count])
            {
                [playlistItemData setObject:mediaSources forKey:@"mediaSources"];
            }
            
            [playlistItems addObject:playlistItemData];
        }
        
        playlistData = @{
            @"count": @([playlistItems count])
            , @"playlistItems": [playlistItems count] ? playlistItems : @[]
        };
    }
    else
    {
        playlistData = @{
            @"count": @(0)
            , @"playlistItems": @[]
        };
    }
    
    return playlistData;
}

- (void) configurePlayer
{
    NSLog(@"[WBRCTJWPlayerView::configurePlayer]");
    
    if (_player)
    {
        if (_player && _player.view && _player.view.superview)
        {
            [_player.view removeFromSuperview];
        }
        
        _player = nil;
    }
    
    if (_playerConfig)
    {
        // The first playlist item that will allow ad playback, index starting at 1.
        // Within the playlist, the first index is 0. If the playlistIndex value is negative, the index starts counting from the end of the playlist.
        // Therfore, playlistIndex = 0 means startOn = 1
        // Therfore, playlistIndex = 1 means startOn = 2
        // Therfore, playlistIndex = 2 means startOn = 3
        
        JWConfig *jwConfig = _playerConfig.jwConfig;
        
        NSLog(@"[WBRCTJWPlayerView::configurePlayer] Has Advertising: %@; Has Advertising Rules: %@; Advertising Rules StartOn equals Playlist Index: %@; Advertising Rules StartOn: %lu; Playlist Index: %lu"
              , _playerConfig.advertising ? @"YES" : @"NO"
              , _playerConfig.advertising && _playerConfig.advertising.rules ? @"YES" : @"NO"
              , _playerConfig.advertising && _playerConfig.advertising.rules && _playerConfig.playlistIndex + 1 == _playerConfig.advertising.rules.startOn ? @"YES" : @"NO"
              , (unsigned long)(_playerConfig.advertising && _playerConfig.advertising.rules ? _playerConfig.advertising.rules.startOn : -999999)
              , (long)_playerConfig.playlistIndex
              );
        
        /*
         if (   _playerConfig.advertising
         && _playerConfig.advertising.rules
         && _playerConfig.advertising.rules.startOn != (_playerConfig.playlistIndex + 1)
         )
         {
         _playerConfig.advertising.rules.startOn = _playerConfig.playlistIndex + 1;
         }
         */
        
        if (
            self.videoPlayList
            && self.videoPlayList.playlist
            && [self.videoPlayList.playlist count]
            )
        {
            if ([self.videoPlayList.playlist count] == 1)
            {
                WBRCTVideoItem *videoItem = self.videoPlayList.playlist[0];
                NSMutableArray *sources   = [NSMutableArray new];
                
                for (WBRCTMediaSource *source in videoItem.mediaSources)
                {
                    JWSource *jwSource = [JWSource sourceWithFile:source.file label:source.qualityLabel isDefault:source.isDefaultQuality];
                    [sources addObject:jwSource];
                }
                
                jwConfig.desc    = videoItem.desc;
                jwConfig.file    = videoItem.file;
                jwConfig.image   = [videoItem.posterImageUrl absoluteString];
                jwConfig.mediaId = videoItem.mediaId;
                jwConfig.title   = videoItem.title;
                
                if (sources && [sources count])
                {
                    jwConfig.sources = sources;
                }
                
                if (   videoItem.adSchedule
                    && [videoItem.adSchedule count]
                    )
                {
                    JWAdConfig *adConfig = [JWAdConfig new];
                    adConfig.skipText    = @"Skip";
                    adConfig.skipOffset  = jwConfig.advertising.skipOffset ? jwConfig.advertising.skipOffset : 5;
                    adConfig.client      = jwConfig.advertising.client     ? jwConfig.advertising.client     : JWAdClientVast;
                    
                    NSMutableArray *adSchedule = [NSMutableArray new];
                    for (WBRCTAdBreak *ad in videoItem.adSchedule)
                    {
                        [adSchedule addObject:[ad adBreak]];
                    }
                    
                    if (adSchedule && [adSchedule count])
                    {
                        adConfig.schedule    = adSchedule;
                    }
                    
                    jwConfig.advertising = adConfig;
                }
            }
            else
            {
                NSMutableArray *playListItems = [NSMutableArray new];
                for (WBRCTVideoItem *videoItem in self.videoPlayList.playlist)
                {
                    JWPlaylistItem *playlistItem = [JWPlaylistItem new];
                    NSMutableArray *sources = [NSMutableArray new];
                    
                    for (WBRCTMediaSource *source in videoItem.mediaSources)
                    {
                        JWSource *jwSource = [JWSource sourceWithFile:source.file label:source.qualityLabel isDefault:source.isDefaultQuality];
                        [sources addObject:jwSource];
                    }
                    
                    playlistItem.desc    = videoItem.desc;
                    playlistItem.file    = videoItem.file;
                    playlistItem.image   = [videoItem.posterImageUrl absoluteString];
                    playlistItem.mediaId = videoItem.mediaId;
                    playlistItem.title   = videoItem.title;
                    
                    if (sources && [sources count])
                    {
                        playlistItem.sources = sources;
                    }
                    
                    //NOTE:- check this out for adding ad tag variables https://support.jwplayer.com/articles/ad-tag-targeting-macro-reference
                    if (    videoItem.adSchedule
                        && [videoItem.adSchedule count]
                        )
                    {
                        NSMutableArray *adSchedule = [NSMutableArray new];
                        for (WBRCTAdBreak *ad in videoItem.adSchedule)
                        {
                            [adSchedule addObject:[ad adBreak]];
                        }
                        
                        if (adSchedule && [adSchedule count])
                        {
                            playlistItem.adSchedule = adSchedule;
                        }
                    }
                    
                    [playListItems addObject:playlistItem];
                }
                
                if (playListItems && [playListItems count])
                {
                    [jwConfig setPlaylist:playListItems];
                }
            }
        }
        
        _player = [[JWPlayerController alloc] initWithConfig:_playerConfig.jwConfig delegate:self];
        _player.openSafariOnAdClick = YES;
        
        [self addSubview:_player.view];
        if (_playerConfig.muted)
        {
            self.volume = kDefaultVolume;
        }
        
        if (_playlistIndex != _playerConfig.playlistIndex)
        {
            _playlistIndex = _playerConfig.playlistIndex;
        }
    }
}

@end
