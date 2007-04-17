/* MyController */

#import <Cocoa/Cocoa.h>

@interface MyController : NSWindowController
{
	float flipv;
	NSView *contentView;
	NSMutableString *css;
	NSMutableString *html;
	NSMutableString *script;

}
- (IBAction)okAction:(id)sender;
- (IBAction)worldAction:(id)sender;

- (void)initReflector;
- (void)render_html;
- (void)render_html_obj:(id)o withBaseX:(int)base_x withBaseY:(int)base_y;

- (void)add_style_for:(id)object withRect:(NSRect)f withColor:(id)color withBaseX:(int)base_x withBaseY:(int)base_y;

@end
