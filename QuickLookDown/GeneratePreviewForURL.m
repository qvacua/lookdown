/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Cocoa/Cocoa.h>
#import <QuickLook/QuickLook.h>
#import "MPMarkdownProcessor.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options) {
    @autoreleasepool {
        if (QLPreviewRequestIsCancelled(preview)) {
            return noErr;
        }

        NSString *html = [MPMarkdownProcessor htmlFromUrl:(__bridge NSURL *) url];
        NSDictionary *props = @{
                (__bridge NSString *) kQLPreviewPropertyTextEncodingNameKey : @"UTF-8",
                (__bridge NSString *) kQLPreviewPropertyMIMETypeKey : @"text/html",
        };

        QLPreviewRequestSetDataRepresentation(
                preview,
                (__bridge CFDataRef) [html dataUsingEncoding:NSUTF8StringEncoding],
                kUTTypeHTML,
                (__bridge CFDictionaryRef) props
        );
    }

    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview) {
    // Implement only if supported
}
