/**
 * Tae Won Ha
 * http://qvacua.com
 * https://github.com/qvacua
 *
 * See LICENSE
 */

#import "MPAppDelegate.h"
#import "MPStyleManager.h"
#import "MPStyle.h"

@implementation MPAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *styleId = [defaults stringForKey:qDefaultsSelectedStyleKey];
    MPStyleManager *styleManager = [MPStyleManager sharedManager];

    if (styleId == nil) {
        NSString *defaultStyleId = styleManager.defaultStyle.identifier;
        [defaults setObject:defaultStyleId forKey:qDefaultsSelectedStyleKey];
        styleId = defaultStyleId;
    }
    
    styleManager.currentStyle = [styleManager styleForIdentifier:styleId];
}

@end
