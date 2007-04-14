#import "NibblerWindow.h"

@implementation NibblerWindow
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	return NSDragOperationCopy;
}
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    [[self delegate] process:[[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType]];
	return YES;
}
@end
