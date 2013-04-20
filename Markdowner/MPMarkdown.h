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

@interface MPMarkdown : NSDocument <VDKQueueDelegate, NSUserInterfaceValidations>

@property MPStyleManager *styleManager;

- (IBAction)styleAction:(id)sender;

@end
