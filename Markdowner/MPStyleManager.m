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

@interface MPStyleManager ()

@property NSDictionary *tagStyle;

@end

@implementation MPStyleManager

- (id)init {
    self = [super init];
    if (self) {
        NSURL *urlOfDefault = [[NSBundle mainBundle] URLForResource:@"default" withExtension:qStyleFileExtension subdirectory:qStylesSubdirectory];
        NSURL *urlOfDark = [[NSBundle mainBundle] URLForResource:@"dark" withExtension:qStyleFileExtension subdirectory:qStylesSubdirectory];
        NSURL *urlOfNote = [[NSBundle mainBundle] URLForResource:@"note" withExtension:qStyleFileExtension subdirectory:qStylesSubdirectory];

        _defaultStyle = [[MPStyle alloc] initWithUrl:urlOfDefault];
        _darkStyle = [[MPStyle alloc] initWithUrl:urlOfDark];
        _noteStyle = [[MPStyle alloc] initWithUrl:urlOfNote];
        _styles = @[self.defaultStyle, self.darkStyle, self.noteStyle];

        _tagStyle = @{
                @1: self.defaultStyle,
                @2: self.darkStyle,
                @3: self.noteStyle,
        };

        _currentStyle = self.defaultStyle;
    }

    return self;
}

+ (MPStyleManager *)sharedManager {
    static MPStyleManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (MPStyle *)styleForTag:(NSInteger)tag {
    return self.tagStyle[@(tag)];
}

- (MPStyle *)styleForIdentifier:(NSString *)identifier {
    for (MPStyle *style in self.styles) {
        if ([style.identifier isEqualToString:identifier]) {
            return style;
        }
    }

    return nil;
}

@end
