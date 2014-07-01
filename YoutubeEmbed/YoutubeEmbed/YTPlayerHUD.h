//
//  YTPlayerHUD.h
//  YoutubeEmbed
//
//  Created by Blade on 6/27/14.
//  Copyright (c) 2014 Blade Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface YTPlayerHUD : UIViewController <YTPlayerViewDelegate>

@property (nonatomic, readonly) BOOL isVisible;

+(void)displayVideoWithId:(NSString *)videoId;
+(void)dismiss;

@end
