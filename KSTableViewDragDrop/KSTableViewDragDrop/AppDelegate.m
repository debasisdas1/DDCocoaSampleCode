//
//  AppDelegate.m
//  KSTableViewDragDrop
//
//  Created by Debasis Das on 12/9/14.
//  Copyright (c) 2014 Knowstack. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self setSourceDataArray:[NSMutableArray array]];
    [self setTargetDataArray:[NSMutableArray array]];
    
    [self.sourceTableView setDraggingSourceOperationMask:NSDragOperationLink forLocal:NO];
    [self.sourceTableView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
    [self.sourceTableView registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];

    [self.targetTableView setDraggingSourceOperationMask:NSDragOperationLink forLocal:NO];
    [self.targetTableView setDraggingSourceOperationMask:NSDragOperationMove forLocal:YES];
    [self.targetTableView registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];

    [self createDemoData];
    [self.sourceTableView reloadData];
}

-(void)createDemoData
{
    [self setSourceDataArray:[NSMutableArray arrayWithArray:@[@"John Doe",@"Jane Doe",@"Debasis Das",@"Mary Jane",@"John Issac",@"Bret Smith"]]];
}

#pragma mark -
#pragma mark Delegate & DataSource Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    long recordCount = 0;
    if (tableView == self.sourceTableView)
    {
        recordCount = [self.sourceDataArray count];
    }
    else if (tableView == self.targetTableView)
    {
        recordCount = [self.targetDataArray count];
    }
    return recordCount;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    NSString *aString;
    if (aTableView == self.sourceTableView)
    {
        aString = [self.sourceDataArray objectAtIndex:rowIndex];
    }
    else if (aTableView == self.targetTableView)
    {
        aString = [self.targetDataArray objectAtIndex:rowIndex];
    }
    else
    {
        aString = @"This table is not handled";
    }
    return aString;
}

#pragma mark Drag & Drop Delegates

- (BOOL)tableView:(NSTableView *)aTableView
writeRowsWithIndexes:(NSIndexSet *)rowIndexes
     toPasteboard:(NSPasteboard*)pboard
{
    if(aTableView == self.sourceTableView ||
       self.targetTableView)
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
        [pboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
        [pboard setData:data forType:NSStringPboardType];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSDragOperation)tableView:(NSTableView*)tv
                validateDrop:(id <NSDraggingInfo>)info
                 proposedRow:(NSInteger)row
       proposedDropOperation:(NSTableViewDropOperation)op
{
    return NSDragOperationEvery;
}


- (BOOL)tableView:(NSTableView*)tv
       acceptDrop:(id <NSDraggingInfo>)info
              row:(NSInteger)row
    dropOperation:(NSTableViewDropOperation)op
{

    NSData *data = [[info draggingPasteboard] dataForType:NSStringPboardType];
    NSIndexSet *rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    //REORDERING IN THE SAME TABLE VIEW BY DRAG & DROP
    if (([info draggingSource] == self.targetTableView) & (tv == self.targetTableView))
    {
        NSArray *tArr = [self.targetDataArray objectsAtIndexes:rowIndexes];
        [self.targetDataArray removeObjectsAtIndexes:rowIndexes];
        
        if (row > self.targetDataArray.count)
        {
            [self.targetDataArray insertObject:[tArr objectAtIndex:0] atIndex:row-1];
        }
        else
        {
            [self.targetDataArray insertObject:[tArr objectAtIndex:0] atIndex:row];
        }
        [self.targetTableView reloadData];
        [self.targetTableView deselectAll:nil];
    }

    //DRAG AND DROP ACROSS THE TABLES
    else if (([info draggingSource] == self.sourceTableView) & (tv == self.targetTableView))
    {
        NSArray *tArr = [self.sourceDataArray objectsAtIndexes:rowIndexes];
        [self.sourceDataArray removeObjectsAtIndexes:rowIndexes];
        [self.targetDataArray addObject:[tArr objectAtIndex:0]];
        [self.sourceTableView reloadData];
        [self.sourceTableView deselectAll:nil];
        [self.targetTableView reloadData];
    }

    else if (([info draggingSource] == self.targetTableView) & (tv == self.sourceTableView))
    {
        NSArray *tArr = [self.targetDataArray objectsAtIndexes:rowIndexes];
        [self.targetDataArray removeObjectsAtIndexes:rowIndexes];
        [self.sourceDataArray addObject:[tArr objectAtIndex:0]];
        [self.targetTableView reloadData];
        [self.targetTableView deselectAll:nil];
        [self.sourceTableView reloadData];
    }

    return YES;
}


@end
