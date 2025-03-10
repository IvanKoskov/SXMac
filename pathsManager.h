//
//  pathsManager.h
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface pathsManager : NSObject

-(NSString *)locateDocumentsFolder;
-(NSString *)filesLocationOnMac;
-(nonnull NSArray<NSString *> *)fileListedOnTheLocation:(nonnull NSString *)folder;
-(BOOL)exportSelectedFile:(nonnull NSString *)path To:(nonnull NSString *)folder;
-(NSString *)deleteTheFile:(NSString *)file;

@end

NS_ASSUME_NONNULL_END
