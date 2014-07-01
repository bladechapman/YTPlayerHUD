//
//  ViewController.m
//  YoutubeEmbed
//
//  Created by Blade on 6/27/14.
//  Copyright (c) 2014 Blade Chapman. All rights reserved.
//

#import "ViewController.h"
#import "YTPlayerView.h"
#import "YTPlayerHUD.h"

@interface ViewController ()

//@property YTPlayerView *playerView;

@end

@implementation ViewController

@synthesize videoView;
- (IBAction)buttonPress:(id)sender
{
//    NSLog(@"button pressed");
//
//    NSString *videoURL = @"http://youtube.com/embed/u5X5cV-4LRo";
//
//    NSString *htmlString = [NSString stringWithFormat:@"\
//    <html>\
//    <head>\
//    <style type=\"text/css\">\
//    iframe {position:absolute; top:50%%; margin-top:-130px;}\
//    body {background-color:#000; margin:0;}\
//    </style>\
//    </head>\
//    <body>\
//    <iframe width=\"640px\" height=\"360px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
//    </body>\
//    </html>", videoURL];
//
//
//    videoView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
//    videoView.delegate = self;
//    [videoView setBackgroundColor:[UIColor blackColor]];
//
//    [videoView loadHTMLString: htmlString
//                      baseURL:nil];
//
//    [self.view addSubview:videoView];

//    _playerView = [[YTPlayerView alloc] initWithFrame:CGRectMake(0, 0, 640, 360)];
//    _playerView.delegate = self;
//    [_playerView loadWithVideoId:@"M7lc1UVf-VE"];
//
//    [self.view addSubview:_playerView];
//    [self.playerView loadWithVideoId:@"M7lc1UVf-VE"];
    NSLog(@"button pressed");
    [YTPlayerHUD displayVideoWithId:@"M7lc1UVf-VE"];

//    [self performSelector:@selector(dismiss) withObject:nil afterDelay:5];
}
-(void)dismiss
{
    [YTPlayerHUD dismiss];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"load started");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finished load");
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error");
}

-(void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error
{
    NSLog(@"error received");
}
-(void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state
{
    if(state == kYTPlayerStateEnded)
    {
        NSLog(@"video ended");
    }
}




@end
