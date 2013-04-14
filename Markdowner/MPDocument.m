/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPDocument.h"
#import "MPDocumentWindowController.h"

const u_int qDefaultFileNotifierEvents = VDKQueueNotifyAboutDelete | VDKQueueNotifyAboutRename | VDKQueueNotifyAboutWrite;

@interface MPDocument ()

@property MPDocumentWindowController *windowController;
@property VDKQueue *kqueue;

@end

@implementation MPDocument

- (id)init {
    self = [super init];

    if (!self) {
        return nil;
    }

    _kqueue = [[VDKQueue alloc] init];
    _kqueue.delegate = self;

    _windowController = [[MPDocumentWindowController alloc] initWithWindowNibName:@"MPDocument"];

    return self;
}

- (void)makeWindowControllers {
    [self addWindowController:self.windowController];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    [self.kqueue addPath:self.fileURL.path notifyingAbout:qDefaultFileNotifierEvents];

    return YES;
}

- (void)dealloc {
    [self.kqueue removeAllPaths];
    self.kqueue = nil;
}

#pragma mark VDKQueueDelegate
- (void)VDKQueue:(VDKQueue *)queue receivedNotification:(NSString *)noteName forPath:(NSString *)fpath {
    /*
    When I use MacVim to edit the file, VDKQueue loses the track of the file after the first saving. Thus, we remove the
    path and add it again.
     */
    [queue removeAllPaths];
    [queue addPath:fpath notifyingAbout:qDefaultFileNotifierEvents];
}

@end
