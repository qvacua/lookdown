/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

static NSString *const qTemplateTitleTag = @"<% TITLE %>";
static NSString *const qTemplateContentTag = @"<% CONTENT %>";
static NSString *const qTemplateStyleRootTag = @"<% STYLE_ROOT %>";

@interface MPStyle : NSObject {
}

@property NSString *identifier;
@property NSString *displayName;
@property NSString *template;

- (id)initWithUrl:(NSURL *)url;

- (NSString *)renderedHtmlWithContent:(NSDictionary *)content;

@end
