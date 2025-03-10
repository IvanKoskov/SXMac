//
//  alertView.h
//  SXMac
//
//  Created by Evan Matthew on 10/3/2568 BE.
//

#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN


@interface alertView : NSObject

- (void)showAlertWithMessage:(NSString *)message; //for files stuff
- (void)showhelphMessage:(NSString *)message; //for user guide

@end

NS_ASSUME_NONNULL_END
