//
//  JpegoptimWorker.h
//
//  Created by porneL on 7.paź.07.
//

#import <Cocoa/Cocoa.h>
#import "CommandWorker.h"

@interface JpegtranWorker : CommandWorker {
    BOOL strip, jpegrescan;
}

@end
