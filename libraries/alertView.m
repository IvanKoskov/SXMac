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
    // Create alert
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"SXMac interface"];
    [alert setInformativeText:message];
    [alert addButtonWithTitle:@"Got it!"];
    
    [alert setAlertStyle:NSAlertStyleInformational];
    
    // without depending on any specific window
    [alert runModal];
}


- (NSString *)promptForFileName {
    // Create the alert with input box
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Enter the file name"];
    [alert setInformativeText:@"Please enter the name of the new desired file:"];
    
    // Create a text field to prompt the user for input
    NSTextField *inputField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [alert setAccessoryView:inputField];
    
    // Add buttons to the alert
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    
    // Run the modal alert
    NSInteger response = [alert runModal];
    
    // Check the response 
    if (response == NSAlertFirstButtonReturn) { // "OK" button
        return [inputField stringValue];
    } else {
        return nil; // Cancel
    }
}



@end
