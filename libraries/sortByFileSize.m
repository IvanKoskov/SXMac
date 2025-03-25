//
//  sortByFileSize.m
//  SXMac
//
//  Created by Evan Matthew on 25/3/25.
//

#import "sortByFileSize.h"

@implementation sortByFileSize


- (NSArray<NSString *> *)sortByFileSize:(NSArray<NSString *> *)files {
    // Count how many files are in the array
    NSUInteger numFiles = [files count];
    
    // Create a mutable copy of the files array to sort
    NSMutableArray<NSString *> *sorted = [files mutableCopy];
    
    // Sorting the files by size (bubble sort)
    for (NSUInteger i = 0; i < numFiles - 1; i++) {
        for (NSUInteger j = 0; j < numFiles - i - 1; j++) {
            
            // Get the user's home directory
            NSString *homeDir = NSHomeDirectory();
            if (!homeDir) {
                NSLog(@"Error: Could not get the home directory.");
                return nil;
            }
            
            // Construct full file path
            NSString *fullPath1 = [homeDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/SXMacFiles/%@", sorted[j]]];
            struct stat st1;
            if (stat([fullPath1 UTF8String], &st1) == -1) {
                NSLog(@"Error: stat failed for first file at path %@", fullPath1);
                return nil;
            }
            long size1 = st1.st_size;
            
            NSString *fullPath2 = [homeDir stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/SXMacFiles/%@", sorted[j + 1]]];
            struct stat st2;
            if (stat([fullPath2 UTF8String], &st2) == -1) {
                NSLog(@"Error: stat failed for second file at path %@", fullPath2);
                return nil;
            }
            long size2 = st2.st_size;
            
            // If the file at index j is smaller than the file at index j + 1, swap them
            if (size1 < size2) {
                [sorted exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }

    // Return the entire sorted array of files
    return sorted;
}

@end
