//
//  PrefsController.m
//
//  Created by porneL on 24.wrz.07.
//

#import "PrefsController.h"
#import "ImageOptim.h"
#import "Transformers.h"

@implementation PrefsController

-(id)init
{
	if ((self = [super initWithWindowNibName:@"PrefsController"]))
	{
		int cpus = [ImageOptim numberOfCPUs];
		maxNumberOfTasks = MIN(cpus*6, MAX(8, cpus * 2 + 2));
		recommendedNumberOfTasks = cpus+2 + (cpus>6?1:0);
		criticalNumberOfTasks = (maxNumberOfTasks + recommendedNumberOfTasks)/2;

		CeilFormatter *cf = [CeilFormatter new];
		[NSValueTransformer setValueTransformer:cf forName:@"CeilFormatter"];

		DisabledColor *dc = [DisabledColor new];
		[NSValueTransformer setValueTransformer:dc forName:@"DisabledColor"];
	}
//	NSLog(@"init prefs %@",self);
	return self;
}


-(IBAction)addGammaChunks:(id)sender
{
	NSArray *chunks = [NSArray arrayWithObjects:@"gAMA",@"sRGB",@"iCCP",@"cHRM",nil];
	NSString *name;
	NSArray *content = [chunksController arrangedObjects];
	BOOL done = NO;

	for(name in chunks)
	{
		NSDictionary *chunk = [NSDictionary dictionaryWithObject:name forKey:@"name"];
		if (NSNotFound == [content indexOfObject:chunk])
		{
			[chunksController addObject:chunk];
			done = YES;
		}
	}
	if (!done) NSBeep();
}

-(IBAction)browseForExecutable:(id)sender
{
    static NSString *const keys[] = {@"JpegOptim",@"AdvPng",@"OptiPng",@"PngCrush",@"PngOut",@"JpegTran",@"Gifsicle"};
	NSInteger tag = [sender tag];
	if (tag >= 1 && tag <= sizeof(keys)/sizeof(keys[0]))
	{
		NSString *key = keys[tag-1];

		NSOpenPanel *oPanel = [NSOpenPanel openPanel];

		[oPanel setAllowsMultipleSelection:NO];
		[oPanel setCanChooseDirectories:NO];
		[oPanel setResolvesAliases:YES];

		[oPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger returnCode) {
            if (returnCode == NSOKButton) {
                NSString *file = [[oPanel filenames] lastObject];
                if (file) {
                    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
                    [defs setObject:file forKey:[key stringByAppendingString:@"Path"]];
                }
            }
        }];
	}
}


-(void)windowDidLoad
{
	[tasksSlider setNumberOfTickMarks:[self maxNumberOfTasks]];
	[tasksSlider setAllowsTickMarkValuesOnly:YES];
}
-(void)showWindow:(id)sender
{
//	NSLog(@"window show?");
	owner = sender;

	[super showWindow:sender];
}


-(IBAction)showHelp:(id)sender
{
	NSInteger tag = [sender tag];

	[[self window] setHidesOnDeactivate:NO];

	NSString *locBookName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleHelpBookName"];
	NSString *anchors[] = {@"general", @"jpegoptim", @"advpng", @"optipng", @"pngcrush", @"pngout"};
	NSString *anchor = @"main";

	if (tag >= 1 && tag <= 6)
	{
		anchor = anchors[tag-1];
	}
	//NSLog(@"opening help for %@ in %@",anchor, locBookName);
	[[NSHelpManager sharedHelpManager] openHelpAnchor:anchor inBook:locBookName];
}
@synthesize tasksSlider;
@synthesize chunksController;
@synthesize maxNumberOfTasks;
@synthesize recommendedNumberOfTasks;
@synthesize criticalNumberOfTasks;
@end
