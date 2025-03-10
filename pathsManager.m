//
//  pathsManager.m
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025
//

#import "pathsManager.h"

@implementation pathsManager




- (nonnull NSString *)filesLocationOnMac {
    
    // Get the path to the Documents directory
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsDirectory firstObject];
    
    // Define the folder name
    NSString *folderName = @"/SXMacFiles";  // Update with the correct folder name
    NSString *pathToFiles = [documentsPath stringByAppendingPathComponent:folderName];
    
    // Log the path for debugging
    NSLog(@"%@", pathToFiles);
    
    // Create the folder if it doesn't exist
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL exists = [fileManager fileExistsAtPath:pathToFiles isDirectory:&isDirectory];
    
    // If the folder doesn't exist, create it
    if (!exists || !isDirectory) {
        NSError *error = nil;
        BOOL success = [fileManager createDirectoryAtPath:pathToFiles withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (success) {
            NSLog(@"Folder created at path: %@", pathToFiles);
        } else {
            NSLog(@"Error creating folder: %@", error.localizedDescription);
        }
    } else {
        NSLog(@"Folder already exists at path: %@", pathToFiles);
    }
    
    return pathToFiles;
}





- (nonnull NSArray<NSString *> *)fileListedOnTheLocation:(nonnull NSString *)folder {
    // Initialize the array to hold file names
    NSArray<NSString *> *filesInTheFolder = @[];
    
    // Create an instance of NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    // Get the list of files in the directory
    filesInTheFolder = [fileManager contentsOfDirectoryAtPath:folder error:&error];
    
    // If there was an error, handle it
    if (error) {
        NSLog(@"Error reading contents of directory: %@", error.localizedDescription);
        return @[]; // Return an empty array in case of error so the program will handle it
    }
    
    return filesInTheFolder;
}




    
- (BOOL)exportSelectedFile:(nonnull NSString *)path To:(nonnull NSString *)folder {
    // Create an instance of NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // Check if the source file exists
    BOOL isDirectory = NO;
    BOOL fileExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!fileExists || isDirectory) {
        NSLog(@"Source file doesn't exist or is a directory.");
        return NO;
    }

    // Ensure the destination folder exists
    BOOL folderExists = [fileManager fileExistsAtPath:folder isDirectory:&isDirectory];
    if (!folderExists || !isDirectory) {
        NSLog(@"Destination folder doesn't exist or is not a directory.");
        return NO;
    }

    // Create destination path by appending the file name to the folder path
    NSString *fileName = [path lastPathComponent];
    NSString *destinationPath = [folder stringByAppendingPathComponent:fileName];

    NSError *error = nil;

    // Move the file to the destination folder
    BOOL success = [fileManager moveItemAtPath:path toPath:destinationPath error:&error];
    
    if (success) {
        NSLog(@"File moved successfully to %@", destinationPath);
        return YES;
    } else {
        NSLog(@"Error moving file: %@", error.localizedDescription);
        return NO;
    }
}




- (NSString *)locateDocumentsFolder {
    
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsDirectory firstObject];
    
    return documentsPath;
}



- (NSString *)deleteTheFile:(NSString *)file {
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsDirectory firstObject];
    
    // Define the folder name
    NSString *folderName = @"/SXMacFiles";  // Update with the correct folder name
    NSString *pathToFiles = [documentsPath stringByAppendingPathComponent:folderName];
    // Create the full path for the file to delete
    NSString *fileToDelete = [pathToFiles stringByAppendingPathComponent:file];
    
    // Log the file path to verify it's correct
    NSLog(@"Attempting to delete file at path: %@", fileToDelete);
    
    // Get the file manager instance
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // Check if the file exists
    if ([manager fileExistsAtPath:fileToDelete]) {
        // Try to delete the file
        NSError *error = nil;
        BOOL success = [manager removeItemAtPath:fileToDelete error:&error];
        if (success) {
            NSLog(@"File %@ successfully deleted.", file);
            return [NSString stringWithFormat:@"File %@ successfully deleted.", file];
        } else {
            // Log the error if deletion fails
            NSLog(@"Failed to delete file %@. Error: %@", file, error.localizedDescription);
            return [NSString stringWithFormat:@"Failed to delete file %@. Error: %@", file, error.localizedDescription];
        }
    } else {
        // File does not exist
        NSLog(@"File %@ does not exist.", file);
        return [NSString stringWithFormat:@"File %@ does not exist.", file];
    }
}


@end
