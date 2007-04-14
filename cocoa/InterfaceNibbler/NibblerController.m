#import "NibblerController.h"
#import "NSDictionary+BSJSONAdditions.h"

@implementation NibblerController
- (void)awakeFromNib
{
	[[self window] registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
}
- (void)writeDimensionInfo:(NSRect)rect toDictionary:(NSMutableDictionary *)data outerBoundHeight:(float)height
{
	#define SO(k, v) [data setObject:[NSNumber numberWithFloat:v] forKey:k]
	SO(@"x", rect.origin.x);
	SO(@"y", height - (rect.origin.y + rect.size.height));
	SO(@"w", rect.size.width);
	SO(@"h", rect.size.height);
	#undef SO
}
- (void)dumpViewData:(NSView*)view toDictionary:(NSMutableDictionary*)dict outerBoundHeight:(float)height
{
	[dict setObject:[view className] forKey:@"class"];
	[self writeDimensionInfo:[view frame] toDictionary:dict outerBoundHeight:height];
	
	if ([[view subviews] count] > 0) {
		NSMutableArray *array = [NSMutableArray array];
		[self dumpSubviewData:[view subviews] toArray:array outerBoundHeight:[view frame].size.height];
		[dict setObject:array forKey:@"objects"];
	}
}
- (void)dumpSubviewData:(NSArray*)subviews toArray:(NSMutableArray*)array outerBoundHeight:(float)height
{
	int i;
	for (i = 0; i < [subviews count]; i++) {
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		[self dumpViewData:[subviews objectAtIndex:i] toDictionary:dict outerBoundHeight:height];
		[array addObject:dict];
	}
}
- (void)process:(id)plist
{
	NSLog(@"process!");
	
	int i;
	for (i = 0; i < [plist count]; i++) {
		NSString *source = [plist objectAtIndex:i];
		
		if (![[source pathExtension] isEqualToString:@"nib"]) {
			[[NSAlert alertWithMessageText:[NSString stringWithFormat:@"%@ is not a .nib file", source] defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"This file will be ignored"] runModal];
			continue;
		}
		
		NSString *dest = [[source stringByDeletingPathExtension] stringByAppendingPathExtension:@".js"];
		
		NSMutableArray *data = [NSMutableArray array];
		
		NSNib *nib = [[NSNib alloc] initWithContentsOfURL:[NSURL fileURLWithPath:source]];
		NSArray *objs;
		[nib instantiateNibWithOwner:self topLevelObjects:&objs];
		
		int j;
		for (j = 0; j < [objs count]; j++) {
			id winobj = [objs objectAtIndex:j];
			
			if (![winobj isKindOfClass:[NSWindow class]]) continue;
			NSMutableDictionary *wdata = [NSMutableDictionary dictionary];
			[wdata setObject:[winobj className] forKey:@"class"];
			[wdata setObject:[winobj title] forKey:@"title"];
			
			NSRect wframe = [winobj frame];
			wframe.origin.y = 0;
			wframe.origin.x = 0;
			[self writeDimensionInfo:wframe toDictionary:wdata outerBoundHeight:[winobj frame].size.height];
			
			NSMutableArray *svd = [NSMutableArray array];
			NSArray *sv = [[winobj contentView] subviews];
			
			[self dumpSubviewData:sv toArray:svd outerBoundHeight:[winobj frame].size.height];
			[wdata setObject:svd forKey:@"objects"];
			
			[data addObject:wdata];
		}
		
		NSLog([objs description]);
	
		NSMutableDictionary *json = [NSMutableDictionary dictionary];
		[json setObject:data forKey:@"nib"];
		
		[[json jsonStringValue] writeToFile:dest atomically:YES encoding:NSUTF8StringEncoding error:nil];		
		[nib release];
	}
}

@end
