//
//  pathsManager.h
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025
//

// PathsManager is a class that is moving and manipulating all the files in the app and instances
// PathsManager provides full MacOS functions implementations for directories, file management and etc.
// Fully back compatible with custom C++ version of it that is deprecated recently, but can be accessed from our repo archive.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface pathsManager : NSObject

-(NSString *)locateDocumentsFolder;

-(NSString *)filesLocationOnMac;

-(nonnull NSArray<NSString *> *)fileListedOnTheLocation:(nonnull NSString *)folder;

-(NSString *)deleteTheFile:(NSString *)file;

-(BOOL)importFileToTheApp:(NSString *)path;

-(BOOL)saveTheNewTextToThefile:(NSString *)pathToFile And:(NSString *)contents;

-(BOOL)createNewFile:(NSString *)fileName At:(NSString *)path;

-(BOOL)exportSelectedFile:(nonnull NSString *)path To:(nonnull NSString *)folder;

-(BOOL)renameFileAtLocation:(NSString *)newFileName andAlso:(NSString *)path andOld:(NSString *)oldFileName;

-(NSString *)createGradientFolderAndFileInside;

-(NSString *)readFilePlain:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
