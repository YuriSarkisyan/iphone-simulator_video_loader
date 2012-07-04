//
//  SVLViewController.m
//  SimulatorVideoLoader
//
//  Created by Юрий Саркисян on 04.07.12.
//  Copyright (c) 2012 I-SYS. All rights reserved.
//

#import "SVLViewController.h"

@interface SVLViewController ()

@end

@implementation SVLViewController
@synthesize loadButton, countLabel, videosListView;

-(void)showLoadProgress
{
    NSString *reportString = [NSString stringWithFormat:@"%d of %d videos left", videoCount, totalVideoCount];
    if (videoFailCount > 0) 
        reportString = [reportString stringByAppendingFormat:@" (%d fails)", videoFailCount];
    
    if (videoCount > 0) 
    {
        self.countLabel.text = reportString;
        loadButton.enabled = NO;
    } 
    else 
    {
        self.countLabel.text = videoFailCount == 0 ? @"No videos left" : reportString;
        loadButton.enabled = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    videoCount = 0;
    self.videosListView.text = [self videosString];
    [self showLoadProgress];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(NSArray *)videosList
{
    static NSArray *paths = nil;
    if (paths == nil) {
        paths = [[[NSBundle mainBundle] pathsForResourcesOfType:@"mov" inDirectory:@"videos"] retain];
    }
    return  paths;
}

-(NSString *)videosString
{
    NSString *string = [[self videosList] componentsJoinedByString:@"\n\n"];
    return string;
}


-(IBAction)loadVideos:(id)sender
{
    videoCount = 0;
    videoFailCount = 0;
    NSArray *paths = [self videosList];
    totalVideoCount = [paths count];
    for (NSString *videoPath in paths) {
        [self loadVideoWithPath:videoPath];
    }
}

-(void)loadVideoWithName:(NSString *)name extension:(NSString *)ext
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    [self loadVideoWithPath:path];
}

-(void)loadVideoWithPath:(NSString *)path
{
    UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishLoadingToAlbumWithError:contextInfo:), nil);
    videoCount ++;
}

-(void)video:(NSString *)videoPath didFinishLoadingToAlbumWithError:(NSError *)error contextInfo:(NSDictionary *)contextInfo
{
    videoCount --;
    if (error != nil) {
        videoFailCount ++;
        NSLog(@"Error while load video: %@", error);
    }
    [self showLoadProgress];
}

@end
