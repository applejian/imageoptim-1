//
//  Worker.h
//
//  Created by porneL on 23.wrz.07.
//

#import <Cocoa/Cocoa.h>
#import "Worker.h"
#import "../File.h"

@interface CommandWorker : Worker {
	File *file;
    NSTask *task;
}
-(id)initWithFile:(File *)aFile;

-(BOOL)parseLine:(NSString *)line;
-(void)parseLinesFromHandle:(NSFileHandle *)commandHandle;

-(void)taskWithPath:(NSString*)path arguments:(NSArray *)arguments;


-(long)readNumberAfter:(NSString *)str inLine:(NSString *)line;

-(void)launchTask;

-(NSString *)tempPath;

-(NSString *)executablePathForKey:(NSString *)prefsName bundleName:(NSString *)resourceName;

-(BOOL)taskForKey:(NSString *)key bundleName:(NSString *)resourceName arguments:(NSArray *)args;

@property (retain) File *file;
@end
