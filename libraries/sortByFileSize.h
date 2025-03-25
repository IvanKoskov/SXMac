//
//  sortByFileSize.h
//  SXMac
//
//  Created by Evan Matthew on 25/3/25.
//

#import <Foundation/Foundation.h>

#import <sys/stat.h>

NS_ASSUME_NONNULL_BEGIN

@interface sortByFileSize : NSObject

- (NSArray<NSString *> *)sortByFileSize:(NSArray<NSString *> *)files;


@end

NS_ASSUME_NONNULL_END
