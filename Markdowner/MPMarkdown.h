/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Cocoa/Cocoa.h>
#import "VDKQueue.h"

@class MPStyleManager;

@interface MPMarkdown : NSDocument <VDKQueueDelegate>

@property MPStyleManager *styleManager;

@end
