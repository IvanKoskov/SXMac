//
//  SXMacMethods.c
//  SXMac
//
//  Created by Evan Matthew on 18/3/2568 BE.
//

#include "SXMacMethods.h"
#include <string.h>


const char* checkSupport(void) {
    // Define the required version (14.6.1)
    SInt32 requiredMajorVersion = 14;
    SInt32 requiredMinorVersion = 6;
    SInt32 requiredBugFixVersion = 1;

    // Get the current macOS version using Gestalt
    SInt32 majorVersion, minorVersion, bugFixVersion;

    Gestalt(gestaltSystemVersionMajor, &majorVersion);
    Gestalt(gestaltSystemVersionMinor, &minorVersion);
    Gestalt(gestaltSystemVersionBugFix, &bugFixVersion);

    // Check if the current version is greater than or equal to 14.6.1
    if (majorVersion > requiredMajorVersion ||
        (majorVersion == requiredMajorVersion && minorVersion > requiredMinorVersion) ||
        (majorVersion == requiredMajorVersion && minorVersion == requiredMinorVersion && bugFixVersion >= requiredBugFixVersion)) {
        
        static char versionString[50];
        snprintf(versionString, sizeof(versionString), "Running on Mac OS X %d.%d.%d (Supported)", majorVersion, minorVersion, bugFixVersion);
        return versionString;
    } else {
        static char versionString[50];
        snprintf(versionString, sizeof(versionString), "Not Supported", majorVersion, minorVersion, bugFixVersion);
        return versionString;
    }
}


