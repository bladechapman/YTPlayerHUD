//
//  YTPlayerHUD.m
//  YoutubeEmbed
//
//  Created by Blade on 6/27/14.
//  Copyright (c) 2014 Blade Chapman. All rights reserved.
//

#import "YTPlayerHUD.h"
#import "YTPlayerView.h"
#import "AppDelegate.h"

@interface YTPlayerHUD ()

@property YTPlayerView *video;
@property UIView *backgroundView;

@end

static YTPlayerHUD *_sharedHUD = nil;
static YTPlayerView *_playerView;

@implementation YTPlayerHUD
{
}

+(void)displayVideoWithId:(NSString *)videoId
{
    if (!_sharedHUD) {
        _sharedHUD = [[YTPlayerHUD alloc] init];
    }

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        _sharedHUD.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    }
    else
    {
        _sharedHUD.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }


    float videoWidth = 720;
    float videoHeight = videoWidth * (9/16.f);


    YTPlayerView *video = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, videoWidth, videoHeight)];
    video.center = CGPointMake(_sharedHUD.view.center.x, _sharedHUD.view.center.y);
    video.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleRightMargin;

    video.delegate = _sharedHUD;
    [video loadWithVideoId:videoId];

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(-_sharedHUD.view.bounds.size.width/2, -_sharedHUD.view.bounds.size.height/2,
                                                                      _sharedHUD.view.bounds.size.width*2,
                                                                      _sharedHUD.view.bounds.size.height*2)];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.4;

    _sharedHUD.video = video;
    _sharedHUD.backgroundView = backgroundView;


    [_sharedHUD.view addSubview:backgroundView];
    [_sharedHUD.view addSubview:video];

    [[YTPlayerHUD topMostController] addChildViewController:_sharedHUD];


}
+(void)dismiss
{
    [UIView animateWithDuration:0.25f animations:^{
        _sharedHUD.view.alpha = 0;

    } completion:^(BOOL finished) {
        for(UIView *view in [_sharedHUD.view subviews])
        {
            [view removeFromSuperview];
        }

        _sharedHUD.video = nil;
        _sharedHUD.backgroundView = nil;
        [_sharedHUD.view removeFromSuperview];
        [_sharedHUD removeFromParentViewController];
    }];
}
+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;

    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    return topController;
}

-(id)init
{
    if(self = [super init])
    {
        self.view.autoresizesSubviews = YES;

        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self.view addGestureRecognizer:singleTapGesture];
    }
    return self;
}

- (void) tapped:(UIGestureRecognizer*)recognizer
{
    UIView *viewTiedWithRecognizer = recognizer.view; // This is the view associated with gesture recognizer.
    if ([viewTiedWithRecognizer class] != [YTPlayerView class]) {
        [YTPlayerHUD dismiss];
    }
}

-(void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    if (state == kYTPlayerStateEnded) {
        [YTPlayerHUD dismiss];
    }
}
-(void)playerViewDidBecomeReady:(YTPlayerView *)playerView
{
    [[YTPlayerHUD topMostController].view addSubview:_sharedHUD.view];
    [playerView playVideo];

    _sharedHUD.view.alpha = 0;
    [UIView animateWithDuration:0.25f animations:^{
        _sharedHUD.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
-(BOOL)shouldAutorotate
{
    return YES;
}

@end
