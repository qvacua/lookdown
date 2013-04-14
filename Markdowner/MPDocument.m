/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPDocument.h"
#import "MPDocumentWindowController.h"
#import <OCDiscount/OCDiscount.h>

static const u_int qDefaultFileNotifierEvents = VDKQueueNotifyAboutDelete | VDKQueueNotifyAboutRename | VDKQueueNotifyAboutWrite;
static NSString *const qDocumentNibName = @"MPDocument";

@interface MPDocument ()

@property MPDocumentWindowController *windowController;
@property VDKQueue *fileWatcher;
@property NSString *markdown;

@end

@implementation MPDocument

- (id)init {
    self = [super init];

    if (!self) {
        return nil;
    }

    _fileWatcher = [[VDKQueue alloc] init];
    _fileWatcher.delegate = self;

    _windowController = [[MPDocumentWindowController alloc] initWithWindowNibName:qDocumentNibName];

    return self;
}

- (void)makeWindowControllers {
    self.windowController.html = [self.markdown htmlFromMarkdown];
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
    self.markdown = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    [self updateFileWatcher:self.fileURL.path];

    return YES;
}

- (void)dealloc {
    [self.fileWatcher removeAllPaths];
    self.fileWatcher = nil;
}

#pragma mark VDKQueueDelegate
- (void)VDKQueue:(VDKQueue *)queue receivedNotification:(NSString *)noteName forPath:(NSString *)path {
    [self updateUi];
    [self updateFileWatcher:path];
}

#pragma mark Private
- (void)updateUi {
    self.markdown = [NSString stringWithContentsOfFile:self.fileURL.path encoding:NSUTF8StringEncoding error:NULL];

    self.windowController.html = [self.markdown htmlFromMarkdown];
    [self.windowController updateWebView];
}

- (void)updateFileWatcher:(NSString *)path {
    /*
    When I use MacVim to edit the file, VDKQueue loses the track of the file after the first saving. Thus, we remove the
    path and add it again.
     */
    [self.fileWatcher removeAllPaths];
    [self.fileWatcher addPath:path notifyingAbout:qDefaultFileNotifierEvents];
}

@end
