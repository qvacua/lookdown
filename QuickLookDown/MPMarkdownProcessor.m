/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <OCDiscount/OCDiscount.h>
#import "MPMarkdownProcessor.h"
#import "MPStyleManager.h"
#import "MPStyle.h"

@implementation MPMarkdownProcessor

+ (NSString *)htmlFromUrl:(NSURL *)url {
    NSString *markdown = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlContent = [markdown htmlFromMarkdown];

    NSString *styleIdOfLookDown = (__bridge NSString *) CFPreferencesCopyAppValue(
            CFSTR("style"),
            CFSTR("com.qvacua.LookDown")
    );

    if (styleIdOfLookDown == nil) {
        styleIdOfLookDown = @"com.qvacua.lookdown.style.default";
    }

    MPStyle *style = [[MPStyleManager sharedManager] styleForIdentifier:styleIdOfLookDown];
    NSString *html = [style renderedHtmlWithContent:@{
            qTemplateTitleTag : url.lastPathComponent,
            qTemplateContentTag : htmlContent,
    }];

    return html;
}

@end