/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPStyleManager.h"
#import "MPStyle.h"

static NSString *const qStylesSubdirectory = @"Styles";
static NSString *const qStyleFileExtension = @"ldstyle";

@implementation MPStyleManager

- (id)init {
    self = [super init];
    if (self) {
        NSURL *urlOfDefault = [[NSBundle mainBundle] URLForResource:@"default" withExtension:qStyleFileExtension subdirectory:qStylesSubdirectory];
        NSURL *urlOfDark = [[NSBundle mainBundle] URLForResource:@"dark" withExtension:qStyleFileExtension subdirectory:qStylesSubdirectory];

        _styles = @[
                [[MPStyle alloc] initWithUrl:urlOfDefault],
                [[MPStyle alloc] initWithUrl:urlOfDark],
        ];
    }

    return self;
}

@end
