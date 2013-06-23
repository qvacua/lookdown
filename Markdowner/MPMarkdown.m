/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPMarkdown.h"
#import "MPDocumentWindowController.h"
#import "MPStyle.h"
#import "MPStyleManager.h"
#import "MPAppDelegate.h"
#import <OCDiscount/OCDiscount.h>


static const u_int qDefaultFileNotifierEvents = VDKQueueNotifyAboutDelete | VDKQueueNotifyAboutRename | VDKQueueNotifyAboutWrite;

static NSString *const qDocumentNibName = @"MPMarkdown";


@interface MPMarkdown ()

@property MPDocumentWindowController *windowController;
@property VDKQueue *fileWatcher;
@property NSString *markdown;

@end


@implementation MPMarkdown

#pragma mark NSDocument
- (void)makeWindowControllers {
    [self generateHtmlAndSetController];
    [self addWindowController:self.windowController];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    _styleManager = [MPStyleManager sharedManager];

    self.markdown = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self updateFileWatcher:self.fileURL.path];

    [self addObserver:self forKeyPath:@"fileURL" options:NSKeyValueObservingOptionNew context:NULL];

    return YES;
}

#pragma mark NSObject
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:@"fileURL"]) {
        return;
    }

    [self updateUi];
    [self updateFileWatcher:self.fileURL.path];
}

#pragma mark VDKQueueDelegate
- (void)VDKQueue:(VDKQueue *)queue receivedNotification:(NSString *)noteName forPath:(NSString *)path {
    if ([noteName isEqualToString:VDKQueueLinkCountChangeNotification]) {
        return;
    }

    if ([noteName isEqualToString:VDKQueueRenameNotification]) {
        /*
         Vim first renames and then overwrites the file. While renamed, the fileWatcher cannot open it and after
         that, open() in VDKQueue does not work anymore...
         */

        return;
    }

    [self updateUi];
    [self updateFileWatcher:path];
}

#pragma mark Private
- (void)updateUi {
    self.markdown = [NSString stringWithContentsOfFile:self.fileURL.path encoding:NSUTF8StringEncoding error:NULL];

    [self generateHtmlAndSetController];
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

- (void)generateHtmlAndSetController {
    NSString *contentFromMarkdown = [self.markdown htmlFromMarkdown];
    if (contentFromMarkdown == nil) {
        contentFromMarkdown = @"<h1>Sorry</h1><p>Something went horribly wrong...</p>";
    }

    self.windowController.html = [_styleManager.currentStyle renderedHtmlWithContent:@{
            qTemplateTitleTag : self.displayName,
            qTemplateContentTag : contentFromMarkdown,
    }];
}

#pragma mark IBActions
- (IBAction)styleAction:(id)sender {
    NSMenuItem *parentItem = [sender parentItem];
    NSMenu *parentMenu = parentItem.submenu;

    for (NSMenuItem *menuItem in parentMenu.itemArray) {
        [menuItem setState:NSOffState];
    }

    [sender setState:NSOnState];
    MPStyle *style = [[MPStyleManager sharedManager] styleForTag:[sender tag]];
    [MPStyleManager sharedManager].currentStyle = style;
    [[NSUserDefaults standardUserDefaults] setObject:style.identifier forKey:qDefaultsSelectedStyleKey];
    [self updateUi];
}

#pragma mark NSUserInterfaceValidations
- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem {
    if ([anItem action] == @selector(styleAction:)) {
        return YES;
    }

    return NO;
}

@end
