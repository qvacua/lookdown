/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Cocoa/Cocoa.h>

@class WebView;

@interface MPDocumentWindowController : NSWindowController

@property (weak) IBOutlet WebView *webView;

- (void)updateWebViewWithHtml:(NSString *)html;

@end
