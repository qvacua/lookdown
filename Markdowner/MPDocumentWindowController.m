/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <WebKit/WebKit.h>
#import "MPDocumentWindowController.h"

@interface MPDocumentWindowController ()

@property CGFloat pageYOffset;
@property CGFloat pageXOffset;

@end

@implementation MPDocumentWindowController

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.scrollTo(%f, %f)", self.pageXOffset, self.pageYOffset]];
}

#pragma mark Public
- (void)updateWebView {
    self.pageYOffset = [self.webView stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"].floatValue;
    self.pageXOffset = [self.webView stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"].floatValue;

    NSString *pathWoLastComponent = [[self.document fileURL].path stringByDeletingLastPathComponent];
    [self.webView.mainFrame loadHTMLString:self.html baseURL:[NSURL URLWithString:pathWoLastComponent]];
}

#pragma mark NSWindowController
- (void)windowDidLoad {
    [super windowDidLoad];

    self.pageYOffset = 0;
    self.pageXOffset = 0;

    [self updateWebView];
}

@end
