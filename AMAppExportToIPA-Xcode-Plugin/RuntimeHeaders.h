//
//  RuntimeHeaders.h
//  AMAppExportToIPA-Xcode-Plugin
//
//  Created by Mellong on 16/2/16.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <APPKit/NSMenu.h>
 #import <Foundation/Foundation.h>

@class DVTFileDataType, NSColor, NSString, NSURL;

@interface IDENavigableItem : NSObject
@property (readonly) IDENavigableItem *parentItem;
@property (readonly) id representedObject;
@end

@interface IDEFileNavigableItem : IDENavigableItem
@property (readonly) DVTFileDataType *documentType;
@property (readonly) NSURL *fileURL;
@end

@interface IDEFileReferenceNavigableItem : IDEFileNavigableItem

+ (id)_createExtraInfoObject;
+ (void)editorDocumentDirtyStatusDidChange:(id)arg1;
+ (void)initialize;
+ (id)keyPathsForValuesAffectingToolTip;
- (unsigned long long)conflictStateForUpdateOrMerge;
- (id)contentDocumentLocation;
- (id)documentType;
- (id)fileReference;
- (NSURL *)fileURL;
- (id)initWithRepresentedObject:(id)arg1;
- (id)name;
- (id)newImage;
- (id)sourceControlCurrentRevision;
- (id)sourceControlLocalStatus;
- (int)sourceControlLocalStatusFlag;
- (id)sourceControlServerStatus;
- (int)sourceControlServerStatusFlag;
@property(readonly) NSColor *textColor;
- (id)toolTip;
- (void)updateAttributes;
- (void)updateChildRepresentedObjects;

@end

@class DVTMapTable, NSArray, NSEvent, NSIndexSet, NSString, NSTextField, NSTextFieldCell, NSTrackingArea;

@protocol DVTProgressIndicatorProvidingView;

@interface DVTOutlineView : NSOutlineView <DVTProgressIndicatorProvidingView>
@property(retain) NSEvent *event; // @synthesize event=_event;
@property BOOL skipGridLinesOnCollapsedGroupRows; // @synthesize skipGridLinesOnCollapsedGroupRows=_skipGridLinesOnCollapsedGroupRows;
@property BOOL skipGridLinesOnLastRow; // @synthesize skipGridLinesOnLastRow=_skipGridLinesOnLastRow;
@property(retain) id itemUnderHoveredMouse; // @synthesize itemUnderHoveredMouse=_itemUnderHoveredMouse;
@property int indentationStyle; // @synthesize indentationStyle=_indentationStyle;
@property int dvt_groupRowStyle; // @synthesize dvt_groupRowStyle=_dvt_groupRowStyle;
@property(nonatomic) long long maxAlternatingRowBackgroundLevelInGroupRow; // @synthesize maxAlternatingRowBackgroundLevelInGroupRow=_maxAlternatingRowBackgroundLevelInGroupRow;
@property(nonatomic) BOOL groupRowBreaksAlternatingRowBackgroundCycle; // @synthesize groupRowBreaksAlternatingRowBackgroundCycle=_groupRowBreaksAlternatingRowBackgroundCycle;
@property(copy) NSIndexSet *draggedRows; // @synthesize draggedRows=_draggedRows;
@property int emptyContentStringStyle; // @synthesize emptyContentStringStyle=_emptyContentStringStyle;
@property(copy, nonatomic) NSString *emptyContentSubtitle; // @synthesize emptyContentSubtitle=_emptyContentSubtitle;
@property(copy, nonatomic) NSString *emptyContentString; // @synthesize emptyContentString=_emptyContentString;
- (unsigned long long)draggingSourceOperationMaskForLocal:(BOOL)arg1;
- (void)setDraggingSourceOperationMask:(unsigned long long)arg1 forLocal:(BOOL)arg2;
- (id)dragImageForRowsWithIndexes:(id)arg1 tableColumns:(id)arg2 event:(id)arg3 offset:(struct CGPoint *)arg4;
- (void)concludeDragOperation:(id)arg1;
- (void)draggingEnded:(id)arg1;
- (unsigned long long)draggingUpdated:(id)arg1;
- (unsigned long long)draggingEntered:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseMoved:(id)arg1;
- (void)delayedProcessMouseMovedEvent;
- (void)restartMouseHoverTimer;
- (void)invalidateMouseHoverTimer;
- (void)updateDisplayOfItemUnderMouse:(id)arg1;
- (void)setItemUnderMouseAndMarkForRedisplay:(id)arg1;
- (void)updateTrackingAreas;
@property BOOL revealsOutlineCellUnderHoveredMouseAfterDelay;
- (void)viewWillMoveToWindow:(id)arg1;
- (void)insertText:(id)arg1;
- (void)doCommandBySelector:(SEL)arg1;
- (void)keyDown:(id)arg1;
- (void)viewWillMoveToSuperview:(id)arg1;
- (void)viewWillDraw;
- (BOOL)_shouldRemoveProgressIndicator:(id)arg1 forItem:(id)arg2 andVisibleRect:(struct CGRect)arg3;
- (void)_showEmptyContentSublabel;
- (void)_hideEmptyContentSublabel;
- (void)_showEmptyContentLabel;
- (void)_hideEmptyContentLabel;
- (id)preparedCellAtColumn:(long long)arg1 row:(long long)arg2;
- (Class)groupRowCellClassForDataCell:(id)arg1;
- (id)_dataCellForGroupRowWithClass:(Class)arg1;
- (id)groupRowFont;
- (void)_drawRowHeaderSeparatorInClipRect:(struct CGRect)arg1;
- (void)drawGridInClipRect:(struct CGRect)arg1;
- (void)_drawBackgroundForGroupRow:(long long)arg1 clipRect:(struct CGRect)arg2 isButtedUpRow:(BOOL)arg3;
- (void)drawBackgroundInClipRect:(struct CGRect)arg1;
- (struct CGRect)frameOfOutlineCellAtRow:(long long)arg1;
- (struct CGRect)frameOfCellAtColumn:(long long)arg1 row:(long long)arg2;
@property(readonly) NSArray *contextMenuSelectedItems;
@property(retain) NSArray *selectedItems;
- (id)_itemsAtIndexes:(id)arg1;
@property(readonly) NSIndexSet *contextMenuSelectedRowIndexes;
@property(readonly) NSIndexSet *clickedRowIndexes;
- (void)setSortDescriptors:(id)arg1;
- (struct CGSize)_adjustFrameSizeToFitSuperview:(struct CGSize)arg1;
@property BOOL allowsSizingShorterThanClipView;
@property BOOL breaksCyclicSortDescriptors;
- (id)progressIndicatorForItem:(id)arg1 createIfNecessary:(BOOL)arg2 progressIndicatorStyle:(unsigned long long)arg3;
- (void)clearProgressIndicators;
- (void)setDelegate:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(struct CGRect)arg1;
- (void)dvt_commonInit;

@end

@class DVTDelayedInvocation, DVTStackBacktrace, IDEOutlineViewGroupInfo, NSArray, NSHashTable, NSMutableIndexSet, NSPredicate, NSString, _IDENavigatorOutlineViewDataSource;


@protocol DVTInvalidation;

@interface IDENavigatorOutlineView : DVTOutlineView <DVTInvalidation>

@end
