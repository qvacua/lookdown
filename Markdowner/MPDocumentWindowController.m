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

- (void)updateWebViewWithHtml:(NSString *)html {
    [self.webView.mainFrame loadHTMLString:html baseURL:[NSURL URLWithString:@"file:///tmp"]];
}

@end
