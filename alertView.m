//
//  alertView.m
//  SXMac
//
//  Created by Evan Matthew on 10/3/2568 BE.
//

#import "alertView.h"

@implementation alertView


- (void)showAlertWithMessage:(NSString *)message {
    // Get the key window of the application (global window)
    NSWindow *keyWindow = [NSApplication sharedApplication].keyWindow;
    
    // If there's no key window, fall back to the main window (if necessary)
    if (!keyWindow) {
        keyWindow = [NSApplication sharedApplication].windows.firstObject;
    }
    
    // Create and configure the alert
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"SXMac EXPORTED"];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"Dismiss"];
    
    // Show the alert as a sheet on the key window (or main window)
    [alert beginSheetModalForWindow:keyWindow completionHandler:nil];
}








- (void)showhelphMessage:(nonnull NSString *)message {
    // Create and configure the alert
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"SXMac interface"];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"Got it!"];
    
    [alert setAlertStyle:NSAlertStyleInformational];
    
    // Display the alert modally, without depending on any specific window
    [alert runModal];
}

@end
