//
//  AppDelegate.m
//  StopWatch
//
//  Created by Debasis Das on 10/13/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.timerCount = 0;
    [self.stopWatchLabelTextField setStringValue:[self getFormattedString]];
}

-(NSString *)getFormattedString
{
    int t = self.timerCount;
    int minQuotient = t / 600;
    int minRemainder = t % 600;
    int secQuotient = minRemainder / 10;
    int secRemainder = minRemainder % 10;
    
    NSString * minString = [NSString stringWithFormat:@"%d",minQuotient];
    NSString * secString = [NSString stringWithFormat:@"%d",secQuotient];
    
    if (secQuotient < 10){
        secString = [NSString stringWithFormat:@"0%@",secString];
    }
    NSString *secRemainderString = [NSString stringWithFormat:@"%d",secRemainder];
    
    return [NSString stringWithFormat:@"%@:%@.%@",minString,secString,secRemainderString];
}
     

-(IBAction)startStopWatch:(id)sender
{
    [self.appTimer invalidate];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self selector:@selector(stopWatch:)
                                                    userInfo:nil repeats:YES];
    self.appTimer = timer;
}

-(IBAction)stopStopWatch:(id)sender
{
    [self.appTimer invalidate];
}

-(IBAction)resetStopWatch:(id)sender
{
    [self.appTimer invalidate];
    self.timerCount = 0;
    [self.stopWatchLabelTextField setStringValue:[self getFormattedString]];
}

- (void)stopWatch:(NSTimer*)theTimer {
    self.timerCount = self.timerCount + 1;
    [self.stopWatchLabelTextField setStringValue:[self getFormattedString]];
    
}


@end
