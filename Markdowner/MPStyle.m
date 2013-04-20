/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPStyle.h"

@interface MPStyle ()

@property NSURL *url;

@end

@implementation MPStyle

- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;

        NSURL *metaUrl = [url URLByAppendingPathComponent:@"meta.json"];
        NSDictionary *meta = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:metaUrl] options:(NSJSONReadingOptions) 0 error:NULL];

        _identifier = meta[@"identifier"];
        _displayName = meta[@"displayName"];

        NSURL *templateUrl = [url URLByAppendingPathComponent:@"template.html"];
        _template = [NSString stringWithContentsOfFile:templateUrl.path encoding:NSUTF8StringEncoding error:NULL];
    }

    return self;
}

- (NSString *)renderedHtmlWithContent:(NSDictionary *)content {
    NSString *result = [self.template stringByReplacingOccurrencesOfString:qTemplateTitleTag withString:content[qTemplateTitleTag]];
    result = [result stringByReplacingOccurrencesOfString:qTemplateStyleRootTag withString:self.url.path];
    result = [result stringByReplacingOccurrencesOfString:qTemplateContentTag withString:content[qTemplateContentTag]];

    return result;
}

@end
