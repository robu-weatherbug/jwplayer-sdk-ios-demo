//
//  ObjCViewController.m
//  JWPlayer-SDK-iOS-Demo
//
//  Created by Amitai Blickstein on 2/26/19.
//  Copyright © 2019 JWPlayer. All rights reserved.
//

#import "ObjCViewController.h"
#import "JWPlayer_SDK_iOS_Demo-Swift.h"
#import <JWPlayer_iOS_SDK/JWPlayerController.h>
#import "WBRCTPlayerConfig.h"
#import "WBRCTVideoPlayList.h"

@interface ObjCViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (nonatomic) JWPlayerController *player;

@end

@interface ObjCViewController (PrivateMethods)

- (void) setUpVideos:(WBRCTVideoPlayList *)videoPlayList;

@end

@implementation ObjCViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * playerConfigJSON = @"{\"advertising\":{\"adMessage\":null,\"client\":null,\"googimaSettings\":null,\"rules\":{\"frequency\":3,\"timeBetweenAds\":0,\"startOn\":1,\"startOnSeek\":null},\"schedule\":[{\"isNonLinear\":false,\"offset\":\"pre\",\"tags\":[\"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.17.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=31&FC1=3&FC10=54&FC14=148&FC15=41&FC16=148&FC17=3&FC2=3&FC3=3&FC5=86&FC6=54&FC7=78&FC8=58&FC9=72&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=6.6&HO2=9&HO3=24&HO4=Grass,%20Oak%20and%20Mulberry&L1=807&L2=Santa%20Clara&L3=California&L5=USA&LNG=en&OS_VERSION=13.3&POSTAL_CODE=95050&UNIT=English&vlat=37.355600&vlon=-121.962400&WO1=55.9&WO2=0&WO4=62&WO5=55.9&WO6=29.87&WO8=43&wst=CA&Z3=95050&idfa=00000000-0000-0000-0000-000000000000&vlat=37.355600&vlon=-121.962400\"]}],\"skipMessage\":\"Skip ad in xx seconds...\",\"skipOffset\":null,\"skipText\":\"Skip Ad\",\"tag\":null,\"vpaidControls\":false},\"autoStart\":true,\"controls\":true,\"fullScreen\":true,\"muted\":false,\"nextUpDisplay\":true,\"nextUpOffset\":-10,\"playlistIndex\":0,\"preload\":true,\"stretching\":\"uniform\"}";
    
    NSString * playListJSON = @"{\"playListItems\":[{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200508-Tow-Truck-Drivers-Path-Blocked-by-Florida-Wildfire-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200508-Tow-Truck-Drivers-Path-Blocked-by-Florida-Wildfire-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200508-Tow-Truck-Drivers-Path-Blocked-by-Florida-Wildfire-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Tow Truck Driver’s Path Blocked by Florida Wildfire\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200508-Tow-Truck-Drivers-Path-Blocked-by-Florida-Wildfire-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200507-Dust-Devil-Swirls-Near-Gilbert-Arizona-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200507-Dust-Devil-Swirls-Near-Gilbert-Arizona-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200507-Dust-Devil-Swirls-Near-Gilbert-Arizona-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Dust Devil Swirls Near Gilbert, Arizona\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200507-Dust-Devil-Swirls-Near-Gilbert-Arizona-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20200506-How-Spiders-Build-Their-Webs-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200506-How-Spiders-Build-Their-Webs-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200506-How-Spiders-Build-Their-Webs-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200506-How-Spiders-Build-Their-Webs-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"How Spiders Build Their Webs\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20200506-How-Spiders-Build-Their-Webs-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200506-Dark-Storm-Clouds-Hang-Over-Conway-South-Carolina-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200506-Dark-Storm-Clouds-Hang-Over-Conway-South-Carolina-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200506-Dark-Storm-Clouds-Hang-Over-Conway-South-Carolina-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Dark Storm Clouds Hang Over Conway\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200506-Dark-Storm-Clouds-Hang-Over-Conway-South-Carolina-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20200505-How-Fireflies-Light-Up-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200505-How-Fireflies-Light-Up-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200505-How-Fireflies-Light-Up-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200505-How-Fireflies-Light-Up-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"How Fireflies Light Up?\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20200505-How-Fireflies-Light-Up-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Residents-Begin-Cleanup-After-Storm-Hits-Mansfield-Missouri-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Residents-Begin-Cleanup-After-Storm-Hits-Mansfield-Missouri-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Residents-Begin-Cleanup-After-Storm-Hits-Mansfield-Missouri-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Residents Begin Cleanup After Storm Hit Missouri\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20200505-Residents-Begin-Cleanup-After-Storm-Hits-Mansfield-Missouri-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200507-Frozen-River-Bursts-Its-Banks-in-Alaska-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200507-Frozen-River-Bursts-Its-Banks-in-Alaska-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200507-Frozen-River-Bursts-Its-Banks-in-Alaska-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200507-Frozen-River-Bursts-Its-Banks-in-Alaska-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Frozen River Bursts Its Banks in Alaska\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20200507-Frozen-River-Bursts-Its-Banks-in-Alaska-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Errant-Trampoline-Bounced-Away-by-Storm-in-Tennessee-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Errant-Trampoline-Bounced-Away-by-Storm-in-Tennessee-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200505-Errant-Trampoline-Bounced-Away-by-Storm-in-Tennessee-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Errant Trampoline Bounced Away by Storm in Tennessee\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20200505-Errant-Trampoline-Bounced-Away-by-Storm-in-Tennessee-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Security-Camera-Captures-Storm-Winds-Blowing-Trash-Cans-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Security-Camera-Captures-Storm-Winds-Blowing-Trash-Cans-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Security-Camera-Captures-Storm-Winds-Blowing-Trash-Cans-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Security Camera Captures Storm Winds Blowing Trash Cans\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20200504-Security-Camera-Captures-Storm-Winds-Blowing-Trash-Cans-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Hailstorm-Batters-Rapid-City-South-Dakota-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Hailstorm-Batters-Rapid-City-South-Dakota-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Hailstorm-Batters-Rapid-City-South-Dakota-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20200504-Hailstorm-Batters-Rapid-City-South-Dakota-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Hailstorm Batters South Dakota\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20200504-Hailstorm-Batters-Rapid-City-South-Dakota-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200504-Lightning-Spreads-Across-Rainbow-During-Thunderstorm-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200504-Lightning-Spreads-Across-Rainbow-During-Thunderstorm-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200504-Lightning-Spreads-Across-Rainbow-During-Thunderstorm-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Lightning Spreads Across Rainbow During Thunderstorm\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200504-Lightning-Spreads-Across-Rainbow-During-Thunderstorm-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20200503-A-Story-Of-Survival-in-Antarctica-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200503-A-Story-Of-Survival-in-Antarctica-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200503-A-Story-Of-Survival-in-Antarctica-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20200503-A-Story-Of-Survival-in-Antarctica-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"A Story of Survival in Antarctica\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20200503-A-Story-Of-Survival-in-Antarctica-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Stunning-Timelapse-Captures-Shelf-Cloud-Gliding-Over-Florida-Sky-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Stunning-Timelapse-Captures-Shelf-Cloud-Gliding-Over-Florida-Sky-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Stunning-Timelapse-Captures-Shelf-Cloud-Gliding-Over-Florida-Sky-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Stunning Timelapse Captures Shelf Cloud Gliding Over Florida Sky\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200502-Stunning-Timelapse-Captures-Shelf-Cloud-Gliding-Over-Florida-Sky-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Iguazu-Falls-275-Impressive-Waterfalls-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Iguazu-Falls-275-Impressive-Waterfalls-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Iguazu-Falls-275-Impressive-Waterfalls-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200502-Iguazu-Falls-275-Impressive-Waterfalls-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"275 Impressive Waterfalls\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200502-Iguazu-Falls-275-Impressive-Waterfalls-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-Waterfalls-Rage-in-Upstate-New-York-After-Heavy-Rain-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-Waterfalls-Rage-in-Upstate-New-York-After-Heavy-Rain-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-Waterfalls-Rage-in-Upstate-New-York-After-Heavy-Rain-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Waterfalls Rage in Upstate New York After Heavy Rain\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200501-Waterfalls-Rage-in-Upstate-New-York-After-Heavy-Rain-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-This-Park-in-Croatia-is-a-Natural-Wonder-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-This-Park-in-Croatia-is-a-Natural-Wonder-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-This-Park-in-Croatia-is-a-Natural-Wonder-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200501-This-Park-in-Croatia-is-a-Natural-Wonder-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"This Park in Croatia is a Natural Wonder\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200501-This-Park-in-Croatia-is-a-Natural-Wonder-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Timelapse-Shows-Morning-Thunderstorm-Sweeping-Across-Southwest-Florida-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Timelapse-Shows-Morning-Thunderstorm-Sweeping-Across-Southwest-Florida-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Timelapse-Shows-Morning-Thunderstorm-Sweeping-Across-Southwest-Florida-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Timelapse Shows Morning Thunderstorm Sweeping Across Southwest Florida\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200430-Timelapse-Shows-Morning-Thunderstorm-Sweeping-Across-Southwest-Florida-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Lake-Michigan-Waves-Crash-Onto-Street-as-Flooding-Affects-Chicago-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Lake-Michigan-Waves-Crash-Onto-Street-as-Flooding-Affects-Chicago-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Lake-Michigan-Waves-Crash-Onto-Street-as-Flooding-Affects-Chicago-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Lake Michigan Waves Crash Onto Street as Flooding Affects Chicago\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200430-Lake-Michigan-Waves-Crash-Onto-Street-as-Flooding-Affects-Chicago-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Surfer-Glides-Through-Stunning-Bioluminescence-Waves-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Surfer-Glides-Through-Stunning-Bioluminescence-Waves-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Surfer-Glides-Through-Stunning-Bioluminescence-Waves-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200430-Surfer-Glides-Through-Stunning-Bioluminescence-Waves-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Surfer Glides Through Stunning Bioluminescence Waves\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200430-Surfer-Glides-Through-Stunning-Bioluminescence-Waves-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20200429-Mammatus-Clouds-Glow-Orang-in-Evening-Sky-After-Storm-Hits-Tulsa-Oklahoma-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200429-Mammatus-Clouds-Glow-Orang-in-Evening-Sky-After-Storm-Hits-Tulsa-Oklahoma-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20200429-Mammatus-Clouds-Glow-Orang-in-Evening-Sky-After-Storm-Hits-Tulsa-Oklahoma-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Mammatus Clouds Glow Orange in Evening Sky in Oklahoma\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20200429-Mammatus-Clouds-Glow-Orang-in-Evening-Sky-After-Storm-Hits-Tulsa-Oklahoma-poster.jpg\"}]}";
    
    WBRCTPlayerConfig *playerConfig = [[WBRCTPlayerConfig alloc] initWithJson:playerConfigJSON];
    WBRCTVideoPlayList *videoPlayList = [[WBRCTVideoPlayList alloc] initWithJson:playListJSON];
    
    _player = [[JWPlayerController alloc]initWithConfig:playerConfig.jwConfig];
    [self setUpVideos:videoPlayList];
    
    
    //JWConfig *config = [JWConfig configWithContentURL:@"http://content.bitsontherun.com/videos/3XnJSIm4-injeKYZS.mp4"];
    //self.player = [[JWPlayerController alloc]initWithConfig:config];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *playerView = self.player.view;
    [self.playerContainerView addSubview:playerView];
    [playerView constrainToSuperview];
}

- (void) setUpVideos:(WBRCTVideoPlayList *)videoPlayList
{
    if (   _player
        && videoPlayList
        && videoPlayList.videoItems
        && videoPlayList.videoItems.count
    )
    {
        if (videoPlayList.videoItems.count == 1)
        {
            WBRCTVideoItem *videoItem = videoPlayList.videoItems[0];
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
            && [videoItem.adSchedule count] )
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
            for (WBRCTVideoItem *videoItem in videoPlayList.videoItems)
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
                
                if ( videoItem.adSchedule
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
@end
