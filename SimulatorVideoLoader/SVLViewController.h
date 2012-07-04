//
//  SVLViewController.h
//  SimulatorVideoLoader
//
//  Created by Юрий Саркисян on 04.07.12.
//  Copyright (c) 2012 I-SYS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SVLViewController : UIViewController
{
    NSInteger videoFailCount;
    NSInteger videoCount;
    NSInteger totalVideoCount;
}

@property (retain) IBOutlet UILabel *countLabel;
@property (retain) IBOutlet UIButton *loadButton;
@property (retain) IBOutlet UITextView *videosListView;

-(IBAction)loadVideos:(id)sender;

@end
