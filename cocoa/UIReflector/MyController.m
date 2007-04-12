#import "MyController.h"

NSMutableString *css;
NSMutableString *html;
NSMutableString *script;

NSString *header = 
@"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"><html lang=\"en\">	\
<head>	\
	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"> \
	<title>untitled</title> \
	<meta name=\"generator\" content=\"TextMate http://macromates.com/\"> \
	<meta name=\"author\" content=\"Lukhnos D. Liu\"> \
	<script src=\"prototype.js\" type=\"text/javascript\"></script> \
</head> \
<body>";

NSString *footer = 
@" </body></html>";


int objcounter = 0;

NSString* objname() {
	return [NSString stringWithFormat:@"object%d", objcounter++];
}

NSString *funcname(SEL selector)
{
	NSString *fn = [NSString stringWithFormat:@"%s", sel_getName(selector)];
	return [fn substringWithRange:NSMakeRange(0, [fn length]-1)];
}

void add_style_for_object(NSString *objname, NSRect f, float flipv, NSString *color)
{
	[css appendString:
		[NSString stringWithFormat:@"#%@ { position: absolute; left:%dpx; top: %dpx; width: %dpx; height: %dpx; border: 1px solid %@; } \n",
			objname,
			(int)f.origin.x, (int)(flipv - (f.origin.y + f.size.height)), (int)f.size.width, (int)f.size.height, color]
	];
}

@implementation MyController
- (IBAction)okAction:(id)sender
{
}
- (IBAction)worldAction:(id)sender
{
}

- (void)awakeFromNib {
	NSLog(@"awake!");
	NSLog([[self window] description]);

	contentView = [[self window] contentView];
	flipv = [contentView frame].size.height;
	
	[self render_html];
}

#define APPEND_DIV(d)		[html appendString: [NSString stringWithFormat:@"<div id=\"%@\">\n", d]]
#define APPEND_END_DIV(d)	[html appendString: @"</div>\n"]


- (void)render_html {
	css  = [[NSMutableString new] retain];
	html = [[NSMutableString new] retain];
	script = [[NSMutableString new] retain];
	
	NSString *mainframe = @"mainframe";
	add_style_for_object(mainframe, [contentView frame], flipv, @"blue");	

	APPEND_DIV(mainframe);
	{
		NSArray *sv = [contentView subviews];

		int i;
		for (i = 0; i<[sv count]; i++) {
			id o = [sv objectAtIndex:i];
			[self render_html_obj:o];
		}
	}
	APPEND_END_DIV(mainframe);

	NSString *str = [NSString stringWithFormat:@"%@\n\n<style>\n%@</style>\n%@\n<script>\n%@</script>\n%@\n", header, css, html, script, footer];
	[str writeToFile:@"/tmp/nibout.html" atomically:TRUE];
}

- (void)render_html_obj:(id)o {

	NSString *oname = objname();

	NSLog(@"==> %@\n", [o className]);
	
	APPEND_DIV(oname);
	if ([o respondsToSelector:@selector(action)])
	{
		SEL s = [o action];
		if (s) {
			NSString *fn = funcname(s);
			
			[script appendString:[NSString stringWithFormat:@"function %@(e) { alert('hi'); }\n", fn]];
			
			[script appendString:[NSString stringWithFormat:@"Event.observe('%@', 'click', %@);\n", oname, fn]];
		}
	}

	if ([[o className] isEqualToString:@"NSTextField"]) {
		[html appendString:[NSString stringWithFormat:@"%@", [o stringValue]]];
		add_style_for_object(oname, [o frame], flipv, @"green");	
	} else if ([[o className] isEqualToString:@"NSScrollView"]) {
		[html appendString:[NSString stringWithFormat:@"<textarea>%@</textarea>", @"...."]];
		add_style_for_object(oname, [o frame], flipv, @"red");					
	} else if ([[o className] isEqualToString:@"NSButton"]) {
		[html appendString:[NSString stringWithFormat:@"<input type=\"button\" value=\"%@\" />", [o title]]];
		add_style_for_object(oname, [o frame], flipv, @"red");					
	}
	else {
		add_style_for_object(oname, [o frame], flipv, @"black");
	}
	
	APPEND_END_DIV(oname);
}

@end
