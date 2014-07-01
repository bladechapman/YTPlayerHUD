//
//  ViewController.h
//  YoutubeEmbed
//
//  Created by Blade on 6/27/14.
//  Copyright (c) 2014 Blade Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface ViewController : UIViewController <YTPlayerViewDelegate>
{

}
@property (strong, nonatomic) UIWebView *videoView;
@property (nonatomic, strong) IBOutlet YTPlayerView *playerView;
- (IBAction)buttonPress:(id)sender;

@end
