/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPStyle.h"

@implementation MPStyle

- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if (self) {
        _url = url;
        _templateUrl = [url URLByAppendingPathComponent:@"template.html"];

        NSURL *metaUrl = [url URLByAppendingPathComponent:@"meta.json"];
        NSDictionary *meta = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:metaUrl] options:(NSJSONReadingOptions) 0 error:NULL];

        _identifier = meta[@"identifier"];
        _displayName = meta[@"displayName"];
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.identifier=%@", self.identifier];
    [description appendFormat:@", self.displayName=%@", self.displayName];
    [description appendFormat:@", self.url=%@", self.url];
    [description appendFormat:@", self.templateUrl=%@", self.templateUrl];
    [description appendString:@">"];
    return description;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToStyle:other];
}

- (BOOL)isEqualToStyle:(MPStyle *)style {
    if (self == style)
        return YES;
    if (style == nil)
        return NO;
    if (self.identifier != style.identifier && ![self.identifier isEqualToString:style.identifier])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    return [self.identifier hash];
}

@end
