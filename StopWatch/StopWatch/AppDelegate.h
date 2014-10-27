//
//  AppDelegate.h
//  StopWatch
//
//  Created by Debasis Das on 10/13/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{

}
@property (nonatomic, retain) NSTimer *appTimer;
@property (nonatomic, assign) int timerCount;
@property (nonatomic, assign) IBOutlet NSTextField *stopWatchLabelTextField;
@end

