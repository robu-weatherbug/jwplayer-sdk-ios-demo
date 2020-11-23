//
//  ObjCViewController.m
//  JWPlayer-SDK-iOS-Demo
//
//  Created by Amitai Blickstein on 2/26/19.
//  Copyright © 2019 JWPlayer. All rights reserved.
//

#import "ObjCViewController.h"
#import "JWPlayer_SDK_iOS_Demo-Swift.h"

//#import <JWPlayer_iOS_SDK/JWPlayerController.h>
#import <JWPlayer_iOS_SDK/JWAdBreak.h>
#import <JWPlayer_iOS_SDK/JWAdRules.h>
#import <JWPlayer_iOS_SDK/JWPlaylistItem.h>
#import <JWPlayer_iOS_SDK/JWConfig.h>
#import <JWPlayer_iOS_SDK/JWAdConfig.h>



#import "WBRCTPlayerConfig.h"
#import "WBRCTVideoPlayList.h"
#import "WBRCTJWPlayerView.h"
#import "WBRCTVideoItem.h"

@interface ObjCViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (nonatomic) WBRCTJWPlayerView *jwPlayerView;

- (void) addAdvertisingToPlaylist:(WBRCTPlayerConfig *)playerConfig toPlaylist:(WBRCTVideoPlayList *) videoPlayList;

@end

/*
@interface ObjCViewController (PrivateMethods)

- (void) setUpVideos:(WBRCTVideoPlayList *)videoPlayList;

@end
*/

@implementation ObjCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *playerConfigJSON_WithPlaylist = @"{\"advertising\":{\"adMessage\":null,\"client\":0,\"googimaSettings\":null,\"rules\":{\"frequency\":2,\"timeBetweenAds\":0,\"startOnSeek\":null},\"schedule\":[{\"isNonLinear\":false,\"offset\":\"pre\",\"tags\":[\"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.19.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=7&FC1=7&FC10=44&FC14=109&FC15=7&FC16=24&FC17=108&FC2=4&FC3=24&FC5=63&FC7=63&FC8=46&FC9=54&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=0.1&HO2=2&HO3=37&HO4=None&L1=511&L2=Germantown&L3=Maryland&L5=USA&LNG=en&OS_VERSION=14.2&POSTAL_CODE=20874&UNIT=English&vlat=39.179600&vlon=-77.254900&WO1=59.2&WO2=7&WO4=39.5&WO5=59.2&WO6=30.3&WO7=1.62&WO8=34.6&wst=MD&Z3=20874&idfa=00000000-0000-0000-0000-000000000000&vlat=39.179600&vlon=-77.254900&vid=__item-mediaid__\"]}],\"skipMessage\":\"Skip ad in xx seconds...\",\"skipOffset\":3,\"skipText\":\"Skip Ad\",\"tag\":null,\"vpaidControls\":false},\"autoStart\":true,\"controls\":true,\"fullScreen\":true,\"muted\":false,\"nextUpDisplay\":true,\"nextUpOffset\":-10,\"playlist\":[{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"0e24e04f-ba1a-4b51-aad0-8c04b801f15d\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Mountain View Fire Brings Mass Destruction to Walker\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"ad79ee95-ebed-47eb-b5e6-d4828ec8295e\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Video Shows Last Sunset Before 66 Days of Darkness\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"7f4a0845-bcf5-44b8-8dc0-612fe437a56f\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Research Vessel Records Meteor Breaking Up\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"32bd0958-7dae-4c21-ab8e-b5703746a517\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Central America Bears Brunt of Hurricane Iota\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"e17d8920-9bdc-455d-b745-84fd621f100b\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Snow Arrives in Central New York\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"1b581e09-4afc-4c46-a2fa-138d894dab5b\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Creek Fire Smolders in Snowy California Landscape\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"7f1019fa-fd52-4c7d-8a41-8e3cdef48f03\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"The Aral Sea’s Disappearance\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"86c337ee-55fc-4f99-b573-ebb27b1df2bc\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Hurricane Iota Makes Landfall in Nicaragua\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"c1536a6c-a47d-4b3d-954c-093c3df5bb9f\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Tree Falls Onto Car\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"17dfe998-f0b9-4ae7-b79a-ef1f932d7f38\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Large Alligator Moseys Across Flooded Road\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"cd07f8c4-57f8-4a7a-8a69-1bff167ffbb6\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"New York City Lashed by Wild Storms\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"3dd27c54-d3c7-4f67-8588-836f0ed0a412\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Three Bears Stop for a Drink in Romania's Carpathian Mountains\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"f938938e-f625-41d1-a31e-8ca19830407e\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Post Office Parking Lot Swallowed by Sinkhole\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"4dd4c3e5-5b62-4be7-8bf2-204d55c0d429\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Large Bison Joins Texas Family at Dining Table\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"cc3ac29a-1d6f-4ca8-9275-7146e14c46ee\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Tropical Storm Eta Turns Sky Purple\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"0188d78a-57a0-4573-b894-54b80adcf649\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Historical Weather Events: Hurricane Camille - 1969\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201114-What-If-Hurricane-Camille-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"f1d82930-4b6f-4f46-af0f-f60ae7298194\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Florida Man Goes Fishing in the Street\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"5a81b9e8-1f6b-4b58-a819-160feb0ff78a\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Storm Clouds Gather Around Sydney\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"45e92e40-574b-4994-af85-5c32aa601823\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Buildings Submerged in Floodwaters After Rainfall\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"c646a924-9162-4651-896e-16d54f7db538\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"How Avalanche Rescue Dogs Are Trained\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-poster.jpg\"}],\"preload\":true,\"stretching\":\"uniform\"}";
    
    NSString *playerConfigJSON_WithoutPlaylist = @"{\"advertising\":{\"adMessage\":null,\"client\":0,\"googimaSettings\":null,\"rules\":{\"frequency\":2,\"timeBetweenAds\":0,\"startOnSeek\":null},\"schedule\":[{\"isNonLinear\":false,\"offset\":\"pre\",\"tags\":[\"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.19.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=7&FC1=7&FC10=44&FC14=109&FC15=7&FC16=24&FC17=108&FC2=4&FC3=24&FC5=63&FC7=63&FC8=46&FC9=54&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=0.1&HO2=2&HO3=37&HO4=None&L1=511&L2=Germantown&L3=Maryland&L5=USA&LNG=en&OS_VERSION=14.2&POSTAL_CODE=20874&UNIT=English&vlat=39.179600&vlon=-77.254900&WO1=59.2&WO2=7&WO4=39.5&WO5=59.2&WO6=30.3&WO7=1.62&WO8=34.6&wst=MD&Z3=20874&idfa=00000000-0000-0000-0000-000000000000&vlat=39.179600&vlon=-77.254900&vid=__item-mediaid__\"]}],\"skipMessage\":\"Skip ad in xx seconds...\",\"skipOffset\":3,\"skipText\":\"Skip Ad\",\"tag\":null,\"vpaidControls\":false},\"autoStart\":true,\"controls\":true,\"fullScreen\":true,\"muted\":false,\"nextUpDisplay\":true,\"nextUpOffset\":-10,\"playlist\":null,\"preload\":true,\"stretching\":\"uniform\"}";
    
    NSString *playListJSON = @"{\"playListItems\":[{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"0e24e04f-ba1a-4b51-aad0-8c04b801f15d\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Mountain View Fire Brings Mass Destruction to Walker\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"ad79ee95-ebed-47eb-b5e6-d4828ec8295e\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Video Shows Last Sunset Before 66 Days of Darkness\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"7f4a0845-bcf5-44b8-8dc0-612fe437a56f\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Research Vessel Records Meteor Breaking Up\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"32bd0958-7dae-4c21-ab8e-b5703746a517\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Central America Bears Brunt of Hurricane Iota\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"e17d8920-9bdc-455d-b745-84fd621f100b\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Snow Arrives in Central New York\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"1b581e09-4afc-4c46-a2fa-138d894dab5b\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Creek Fire Smolders in Snowy California Landscape\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201118-Creek-Fire-Smolders-in-Snowy-California-Landscape-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"7f1019fa-fd52-4c7d-8a41-8e3cdef48f03\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"The Aral Sea’s Disappearance\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201117-The-Story-Of-The-Aral-Seas-Disappearance-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"86c337ee-55fc-4f99-b573-ebb27b1df2bc\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Hurricane Iota Makes Landfall in Nicaragua\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201117-Category-4-Hurricane-Iota-Makes-Landfall-in-Nicaragua-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"c1536a6c-a47d-4b3d-954c-093c3df5bb9f\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Tree Falls Onto Car\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201117-Tree-Falls-Onto-Car-as-Strong-Winds-Tear-Through-Dayton-Ohio-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"17dfe998-f0b9-4ae7-b79a-ef1f932d7f38\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Large Alligator Moseys Across Flooded Road\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201116-Large-Alligator-Moseys-Across-Flooded-Road-in-Everglades-National-Park-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"cd07f8c4-57f8-4a7a-8a69-1bff167ffbb6\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"New York City Lashed by Wild Storms\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201116-New-York-City-Lashed-by-Wild-Storms-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"3dd27c54-d3c7-4f67-8588-836f0ed0a412\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Three Bears Stop for a Drink in Romania's Carpathian Mountains\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201116-Three-Bears-Stop-for-a-Drink-in-Romanias-Carpathian-Mountains-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"f938938e-f625-41d1-a31e-8ca19830407e\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Post Office Parking Lot Swallowed by Sinkhole\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201115-Post-Office-Parking-Lot-Swallowed-by-Sinkhole-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"4dd4c3e5-5b62-4be7-8bf2-204d55c0d429\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Large Bison Joins Texas Family at Dining Table\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Animals/20201115-Large-Bison-Joins-Texas-Family-at-Dining-Table-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"cc3ac29a-1d6f-4ca8-9275-7146e14c46ee\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Tropical Storm Eta Turns Sky Purple\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201114-Tropical-Storm-Eta-Turns-Southeast-Florida-Sky-Purple-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"0188d78a-57a0-4573-b894-54b80adcf649\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201114-What-If-Hurricane-Camille-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Historical Weather Events: Hurricane Camille - 1969\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201114-What-If-Hurricane-Camille-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"f1d82930-4b6f-4f46-af0f-f60ae7298194\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Florida Man Goes Fishing in the Street\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Fun/20201113-Florida-Man-Goes-Fishing-in-The-Street-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"5a81b9e8-1f6b-4b58-a819-160feb0ff78a\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Storm Clouds Gather Around Sydney\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201113-Storm-Clouds-Gather-Around-Sydney-as-Severe-Weather-Warnings-Issued-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"45e92e40-574b-4994-af85-5c32aa601823\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Buildings Submerged in Floodwaters After Rainfall\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201113-Hiddenite-Buildings-Submerged-in-Raging-Floodwaters-After-Historic-Rainfall-poster.jpg\"},{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"c646a924-9162-4651-896e-16d54f7db538\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"How Avalanche Rescue Dogs Are Trained\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-poster.jpg\"}]}";
    
    
    /*
     {\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"0e24e04f-ba1a-4b51-aad0-8c04b801f15d\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Mountain View Fire Brings Mass Destruction to Walker\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-poster.jpg\"}
     ,{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"ad79ee95-ebed-47eb-b5e6-d4828ec8295e\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Video Shows Last Sunset Before 66 Days of Darkness\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-poster.jpg\"}
     ,{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"7f4a0845-bcf5-44b8-8dc0-612fe437a56f\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Research Vessel Records Meteor Breaking Up\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-poster.jpg\"}
     ,{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"32bd0958-7dae-4c21-ab8e-b5703746a517\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-1080p.mp4\",\"qualityLabel\":\"1080p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Central America Bears Brunt of Hurricane Iota\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-poster.jpg\"}
     ,{\"adSchedule\":null,\"description\":\"\",\"file\":null,\"mediaId\":\"e17d8920-9bdc-455d-b745-84fd621f100b\",\"mediaSources\":[{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-720p.mp4\",\"qualityLabel\":\"720p\",\"isDefaultQuality\":true},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-540p.mp4\",\"qualityLabel\":\"540p\",\"isDefaultQuality\":false},{\"file\":\"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-360p.mp4\",\"qualityLabel\":\"360p\",\"isDefaultQuality\":false}],\"title\":\"Snow Arrives in Central New York\",\"posterImageUrl\":\"https://content.weatherbug.net/videos/thumbnails/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-poster.jpg\"}
     */

    JWAdBreak *adBreak = [JWAdBreak
                          adBreakWithTag:@"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.19.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=7&FC1=7&FC10=44&FC14=109&FC15=7&FC16=24&FC17=108&FC2=4&FC3=24&FC5=63&FC7=63&FC8=46&FC9=54&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=0.1&HO2=2&HO3=37&HO4=None&L1=511&L2=Germantown&L3=Maryland&L5=USA&LNG=en&OS_VERSION=14.2&POSTAL_CODE=20874&UNIT=English&vlat=39.179600&vlon=-77.254900&WO1=59.2&WO2=7&WO4=39.5&WO5=59.2&WO6=30.3&WO7=1.62&WO8=34.6&wst=MD&Z3=20874&idfa=00000000-0000-0000-0000-000000000000&vlat=39.179600&vlon=-77.254900&vid=__item-mediaid__"
                          offset:@"pre"
                        ];
    
    JWAdRules *adRules = [JWAdRules  new];
    //[adRules setStartOn:1];
    [adRules setFrequency:2];
    //adRules.startOn = 4;
    //adRules.frequency = 2;
    
    JWPlaylistItem *item1 = [[JWPlaylistItem alloc] init];
    item1.file = @"https://content.weatherbug.net/videos/Extreme/20201120-Mountain-View-Fire-Brings-Mass-Destruction-to-Walker-California-720p.mp4";
    item1.title = @"Mountain View Fire Brings Mass Destruction to Walker";
    
    JWPlaylistItem *item2 = [[JWPlaylistItem alloc] init];
    item2.file = @"https://content.weatherbug.net/videos/Earth/20201119-Timelapse-Shows-Last-Sunset-Before-Polar-Night-Brings-Darkness-to-Alaska-720p.mp4";
    item2.title = @"Video Shows Last Sunset Before 66 Days of Darkness";
    
    JWPlaylistItem *item3 = [[JWPlaylistItem alloc] init];
    item3.file = @"https://content.weatherbug.net/videos/Earth/20201119-Australian-Research-Vessel-Records-Meteor-Breaking-Up-Over-Tasman-Sea-720p.mp4";
    item3.title = @"Research Vessel Records Meteor Breaking Up";
    
    JWPlaylistItem *item4 = [[JWPlaylistItem alloc] init];
    item4.file = @"https://content.weatherbug.net/videos/Extreme/20201118-Central-America-Bears-Brunt-Of-Hurricane-Iota-1080p.mp4";
    item4.title = @"Central America Bears Brunt of Hurricane Iota";
    
    JWPlaylistItem *item5 = [[JWPlaylistItem alloc] init];
    item5.file = @"https://content.weatherbug.net/videos/Earth/20201118-Snow-Arrives-in-Central-New-York-Before-Coldest-Day-of-the-Season-720p.mp4";
    item5.title = @"Snow Arrives in Central New York";
    
    JWConfig *jwConfigWithPlaylist = [JWConfig configWithContentURL:@"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-1080p.mp4"];
    jwConfigWithPlaylist.advertising = [JWAdConfig new];
    jwConfigWithPlaylist.advertising.tag = @"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.19.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=7&FC1=7&FC10=44&FC14=109&FC15=7&FC16=24&FC17=108&FC2=4&FC3=24&FC5=63&FC7=63&FC8=46&FC9=54&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=0.1&HO2=2&HO3=37&HO4=None&L1=511&L2=Germantown&L3=Maryland&L5=USA&LNG=en&OS_VERSION=14.2&POSTAL_CODE=20874&UNIT=English&vlat=39.179600&vlon=-77.254900&WO1=59.2&WO2=7&WO4=39.5&WO5=59.2&WO6=30.3&WO7=1.62&WO8=34.6&wst=MD&Z3=20874&idfa=00000000-0000-0000-0000-000000000000&vlat=39.179600&vlon=-77.254900&vid=__item-mediaid__";
    jwConfigWithPlaylist.advertising.client = JWAdClientVast;
    jwConfigWithPlaylist.advertising.schedule = @[adBreak];
    jwConfigWithPlaylist.advertising.rules = adRules;
    jwConfigWithPlaylist.advertising.skipMessage = @"Skip ad in xx seconds...";
    jwConfigWithPlaylist.advertising.skipOffset = 3;
    jwConfigWithPlaylist.advertising.skipText = @"Skip Ad";
    jwConfigWithPlaylist.playlist = @[item1, item2, item3, item4, item5];
    jwConfigWithPlaylist.autostart = YES;
    
    
    JWConfig *jwConfigWithoutPlaylist = [JWConfig configWithContentURL:@"https://content.weatherbug.net/videos/Educational/20201112-How-Avalanche-Rescue-Dogs-Are-Trained-1080p.mp4"];
    jwConfigWithoutPlaylist.advertising = [JWAdConfig new];
    jwConfigWithoutPlaylist.advertising.tag = @"https://ib.adnxs.com/ptv?id=14490244&vmaxduration=30&vskippable=1&vplaybackmethod=3&vwidth=640&vheight=360&vcontext=1&vframeworks=5&vv=3&referrer=com.aws.weatherbug.pro&appid=id281940292&pc=sizmekvast&APP_VERSION=5.19.0&CP=&D1=&D3=&DVC=phone&E1=&FC0=7&FC1=7&FC10=44&FC14=109&FC15=7&FC16=24&FC17=108&FC2=4&FC3=24&FC5=63&FC7=63&FC8=46&FC9=54&gci=&gco=&GEOLOCATION=&gst=&gzc=&HO1=0.1&HO2=2&HO3=37&HO4=None&L1=511&L2=Germantown&L3=Maryland&L5=USA&LNG=en&OS_VERSION=14.2&POSTAL_CODE=20874&UNIT=English&vlat=39.179600&vlon=-77.254900&WO1=59.2&WO2=7&WO4=39.5&WO5=59.2&WO6=30.3&WO7=1.62&WO8=34.6&wst=MD&Z3=20874&idfa=00000000-0000-0000-0000-000000000000&vlat=39.179600&vlon=-77.254900&vid=__item-mediaid__";
    jwConfigWithoutPlaylist.advertising.client = JWAdClientVast;
    jwConfigWithoutPlaylist.advertising.schedule = @[adBreak];
    jwConfigWithoutPlaylist.advertising.rules = adRules;
    jwConfigWithoutPlaylist.advertising.skipMessage = @"Skip ad in xx seconds...";
    jwConfigWithoutPlaylist.advertising.skipOffset = 3;
    jwConfigWithoutPlaylist.advertising.skipText = @"Skip Ad";
    jwConfigWithoutPlaylist.autostart = YES;
    
    

    WBRCTPlayerConfig *playerConfigWithPlaylist = [[WBRCTPlayerConfig alloc] initWithJson:playerConfigJSON_WithPlaylist];
    WBRCTPlayerConfig *playerConfigWithoutPlaylist = [[WBRCTPlayerConfig alloc] initWithJson:playerConfigJSON_WithoutPlaylist];
    WBRCTPlayerConfig *playerConfigNativeWithPlaylist = [[WBRCTPlayerConfig alloc] initWithConfig:jwConfigWithPlaylist];
    WBRCTPlayerConfig *playerConfigNativeWithoutPlaylist = [[WBRCTPlayerConfig alloc] initWithConfig:jwConfigWithoutPlaylist];
    
    WBRCTVideoPlayList *playlist = [[WBRCTVideoPlayList alloc] initWithJson:playListJSON];
    
    
    NSInteger playlistIndex = 2;
    NSUInteger startOn      = 5;
    
    
    _jwPlayerView = [[WBRCTJWPlayerView alloc] init];
    _jwPlayerView.delegate = self;
    _jwPlayerView.onFirstFrame = @selector(onFirstFrame);
    
    
    // When first loading a playlist, the config needs to have playlistIndex
    // When moving to another playlist item, user the playerView to set it
    
    // 1. From JWConfig with playlist
    //[jwConfigWithPlaylist setPlaylistIndex:playlistIndex];
    [_jwPlayerView setPlayerConfigNative:jwConfigWithPlaylist];
    [_jwPlayerView setPlaylistIndex:playlistIndex];
        
    // 2. From JWConfig without playlist
    //[jwConfigWithoutPlaylist setPlaylistIndex:playlistIndex];
    //[_jwPlayerView setPlayerConfigNative:jwConfigWithoutPlaylist];
    //[_jwPlayerView setVideoPlayList:playlist];
    //[_jwPlayerView setPlaylistIndex:playlistIndex];
    
    // 3. JSON Config with playlist
    //[_jwPlayerView setPlayerConfig:playerConfigWithPlaylist];
    //[_jwPlayerView setPlaylistIndex:playlistIndex];
    
    // 4. JSON Config without playlist
    //[_jwPlayerView setPlayerConfig:playerConfigWithoutPlaylist];
    //[_jwPlayerView setVideoPlayList:playlist];

    
}

- (void) onFirstFrame
{
    NSLog(@"[ObjCViewController::onFirstFrame]");
}

- (void) onFirstFrame: (NSNumber *) playlistIndex
{
    NSLog(@"[ObjCViewController::onFirstFrame] Playlist Index: %ld", playlistIndex.longValue);
    
    if (playlistIndex.integerValue != 2)
    {
        [_jwPlayerView setPlaylistIndex:2];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.playerContainerView addSubview:_jwPlayerView];
    [_jwPlayerView constrainToSuperview];
}

- (void) addAdvertisingToPlaylist:(WBRCTPlayerConfig *)playerConfig
{
    if (   playerConfig
        && playerConfig.advertising
        && playerConfig.advertising.schedule
        && [playerConfig.advertising.schedule count]
        && playerConfig.playlist
        && [playerConfig.playlist count]
    )
    {
        for (WBRCTVideoItem *videoItem in playerConfig.playlist)
        {
            videoItem.adSchedule = [playerConfig.advertising.schedule copy];
        }
    }
}

- (void) addAdvertisingToPlaylist:(WBRCTPlayerConfig *)playerConfig toPlaylist:(WBRCTVideoPlayList *) videoPlayList
{
    if (   playerConfig
        && playerConfig.advertising
        && playerConfig.advertising.schedule
        && [playerConfig.advertising.schedule count]
        && videoPlayList
        && videoPlayList.playlist
        && [videoPlayList.playlist count]
    )
    {
        for (WBRCTVideoItem *videoItem in videoPlayList.playlist)
        {
            videoItem.adSchedule = [playerConfig.advertising.schedule copy];
        }
    }
}

/*
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
*/
@end
