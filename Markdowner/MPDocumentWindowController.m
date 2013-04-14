/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <WebKit/WebKit.h>
#import "MPDocumentWindowController.h"

@implementation MPDocumentWindowController {
}

- (void)updateWebView {
    NSString *pathWoLastComponent = [[self.document fileURL].path stringByDeletingLastPathComponent];
    [self.webView.mainFrame loadHTMLString:self.html baseURL:[NSURL URLWithString:pathWoLastComponent]];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self updateWebView];
}

@end
