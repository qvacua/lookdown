/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

@interface MPStyle : NSObject {
}

@property NSString *identifier;
@property NSString *displayName;
@property NSURL *url;
@property NSURL *templateUrl;

- (id)initWithUrl:(NSURL *)url;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToStyle:(MPStyle *)style;

- (NSUInteger)hash;


@end
