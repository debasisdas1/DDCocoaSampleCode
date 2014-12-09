//
//  AppDelegate.h
//  KSTableViewDragDrop
//
//  Created by Debasis Das on 12/9/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, retain) NSMutableArray *sourceDataArray;
@property (nonatomic, retain) NSMutableArray *targetDataArray;
@property (nonatomic, assign) IBOutlet NSTableView *sourceTableView;
@property (nonatomic, assign) IBOutlet NSTableView *targetTableView;




@end

