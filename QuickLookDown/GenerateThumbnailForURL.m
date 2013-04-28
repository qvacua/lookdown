/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Cocoa/Cocoa.h>
#import <QuickLook/QuickLook.h>
#import <Webkit/WebKit.h>
#import "MPMarkdownProcessor.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize) {
    @autoreleasepool {
        if (QLThumbnailRequestIsCancelled(thumbnail)) {
            return noErr;
        }

        NSString *html = [MPMarkdownProcessor htmlFromUrl:(__bridge NSURL *) url];

        NSRect webViewRect = NSMakeRect(0, 0, 640, 640);
        WebView *webView = [[WebView alloc] initWithFrame:webViewRect];

        [webView.mainFrame loadHTMLString:html baseURL:nil];
        while ([webView isLoading]) {
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
        }

        NSBitmapImageRep *bitmap = [webView bitmapImageRepForCachingDisplayInRect:webView.bounds];
        [bitmap setSize:webViewRect.size];
        [webView cacheDisplayInRect:webView.bounds toBitmapImageRep:bitmap];

        NSImage *image = [[NSImage alloc] initWithData:bitmap.TIFFRepresentation];
        CGImageRef cgImage = [image CGImageForProposedRect:NULL context:NULL hints:nil];
        QLThumbnailRequestSetImage(thumbnail, cgImage, NULL);
        CFRelease(cgImage);
    }

    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail) {
    // Implement only if supported
}
