/* MyController */

#import <Cocoa/Cocoa.h>

@interface MyController : NSWindowController
{
	float flipv;
	NSView *contentView;
}
- (IBAction)okAction:(id)sender;
- (IBAction)worldAction:(id)sender;

- (void)render_html;
- (void)render_html_obj:(id)obj;

@end
