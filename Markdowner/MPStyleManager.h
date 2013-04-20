/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import <Foundation/Foundation.h>

@class MPStyle;

@interface MPStyleManager : NSObject

@property NSArray *styles;
@property MPStyle *defaultStyle;
@property MPStyle *darkStyle;
@property MPStyle *currentStyle;

+ (MPStyleManager *)sharedManager;
- (MPStyle *)styleForTag:(NSInteger)tag;
- (MPStyle *)styleForIdentifier:(NSString *)identifier;

@end
