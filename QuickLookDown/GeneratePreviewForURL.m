/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Cocoa/Cocoa.h>
#import <QuickLook/QuickLook.h>
#import <OCDiscount/OCDiscount.h>
#import "MPStyleManager.h"
#import "MPStyle.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options) {
    @autoreleasepool {
        if (QLPreviewRequestIsCancelled(preview)) {
            return (OSStatus) noErr;
        }

        NSString *markdown = [NSString stringWithContentsOfURL:(__bridge NSURL *) url encoding:NSUTF8StringEncoding error:NULL];
        NSString *htmlContent = [markdown htmlFromMarkdown];

        NSString *styleIdOfLookDown = (__bridge NSString *) CFPreferencesCopyAppValue(
                CFSTR("style"),
                CFSTR("com.qvacua.LookDown")
        );

        MPStyle *style = [[MPStyleManager sharedManager] styleForIdentifier:styleIdOfLookDown];
        NSString *html = [style renderedHtmlWithContent:@{
                qTemplateTitleTag : [(__bridge NSURL *) url lastPathComponent],
                qTemplateContentTag : htmlContent,
        }];

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

    return (OSStatus) noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview) {
    // Implement only if supported
}
