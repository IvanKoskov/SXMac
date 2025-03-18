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
   /*
    BOOL isDirectory = NO;
    BOOL fileExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    if (!fileExists || isDirectory) {
        NSLog(@"Source file doesn't exist or is a directory.");
        return NO;
    }
*/
    // Ensure the destination folder exists
  /*  BOOL folderExists = [fileManager fileExistsAtPath:folder isDirectory:&isDirectory];
    if (!folderExists || !isDirectory) {
        NSLog(@"Destination folder doesn't exist or is not a directory.");
        return NO;
    } */

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


- (BOOL)importFileToTheApp:(NSString *)path {
    
    // Get the documents directory
    NSArray *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsDirectory firstObject];
    
    // Define the folder name (make sure this folder exists)
    NSString *folderName = @"/SXMacFiles";  // Update with the correct folder name
    NSString *destinationFolderPath = [documentsPath stringByAppendingPathComponent:folderName];
    
    // Make sure the folder exists, if not, create it
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:destinationFolderPath]) {
        NSError *error = nil;
        BOOL success = [fileManager createDirectoryAtPath:destinationFolderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (!success) {
            NSLog(@"Failed to create directory: %@", error.localizedDescription);
            return NO;
        }
    }
    
    // Get the file name from the source path
    NSString *fileName = [path lastPathComponent];
    NSString *destinationFilePath = [destinationFolderPath stringByAppendingPathComponent:fileName];
    
    // Check if the item at the destination is a file or directory
    BOOL isDirectory = NO;
    if ([fileManager fileExistsAtPath:destinationFilePath isDirectory:&isDirectory]) {
        // Handle the case where the destination already exists
        if (isDirectory) {
            NSLog(@"A directory with the same name already exists at destination: %@", destinationFilePath);
            return NO;  // You can't move a file into a directory with the same name
        } else {
            NSLog(@"A file with the same name already exists at destination: %@", destinationFilePath);
            return NO;  // A file already exists with this name
        }
    }
    
    // Try moving the file or directory to the destination
    NSError *error = nil;
    BOOL success = NO;
    
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            // It's a directory, use moveItemAtPath for directories
            success = [fileManager moveItemAtPath:path toPath:destinationFilePath error:&error];
        } else {
            // It's a file, use moveItemAtPath for files
            success = [fileManager moveItemAtPath:path toPath:destinationFilePath error:&error];
        }
    }
    
    if (success) {
        NSLog(@"Item moved successfully to %@", destinationFilePath);
        return YES;
    } else {
        NSLog(@"Error moving item: %@", error.localizedDescription);
        return NO;
    }
}


- (BOOL)saveTheNewTextToThefile:(nonnull NSString *)pathToFile And:(nonnull NSString *)contents {
    
    NSFileManager *fileManager = [NSFileManager defaultManager]; //make a file manager
    
    // Check 
    if (![fileManager fileExistsAtPath:pathToFile]) {
        NSError *error = nil;
        [fileManager createFileAtPath:pathToFile contents:nil attributes:nil];
        if (error) {
            NSLog(@"Error creating file: %@", error.localizedDescription);
            return NO;
        }
    }
    
    // Write
    NSError *writeError = nil;
    BOOL success = [contents writeToFile:pathToFile atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
    
    if (writeError) {
        NSLog(@"Error writing to file: %@", writeError.localizedDescription);
        return NO;
    }
    
    return YES; // success
}




- (BOOL)createNewFile:(NSString *)fileName At:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *pathToFile = [path stringByAppendingPathComponent:fileName];
    
    if (![fileManager fileExistsAtPath:pathToFile]) {
        NSError *error = nil;
        BOOL success = [fileManager createFileAtPath:pathToFile contents:nil attributes:nil];
        if (!success) {
            // Handle the error properly
            NSLog(@"Error creating file: %@", error.localizedDescription);
            return NO;
        }
    }
    
    return YES; // success
}



- (BOOL)renameFileAtLocation:(nonnull NSString *)newFileName andAlso:(NSString *)path andOld:(NSString *)oldFileName {
    
   
    NSString *oldPath = [path stringByAppendingPathComponent:oldFileName];
    NSString *newPath = [path stringByAppendingPathComponent:newFileName];
    
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    
    // Attempt to rename the file
    BOOL success = [fileManager moveItemAtPath:oldPath toPath:newPath error:&error];
    
    if (success) {
        return YES; // Success
    } else {
      
        NSLog(@"Error renaming file: %@", error.localizedDescription);
        return NO; // Failure
    }
}


@end
