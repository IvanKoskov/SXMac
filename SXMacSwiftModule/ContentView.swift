//
//
//  SXMac //
//
//  Created by Evan Matthew on 09/03/2025
//
//SXMac © 2025 by Ivan Koskov (aka Evan Matthew) is licensed under Creative Commons Attribution-NonCommercial 4.0 International
//
//To view a copy of this license, visit https://creativecommons.org/licenses/by-nc/4.0/




import SwiftUI
import Foundation






func openTextEditor(fileNameToEdit: String) -> String? {
    let pathsManager = pathsManager() // Objective-C class
    let folder = pathsManager.filesLocationOnMac() // calling method from Objective-C
    
    // Ensure the folder ends with a "/"
    let fullPathToFile = (folder as NSString).appendingPathComponent(fileNameToEdit)
    
    let fileManager = FileManager.default
    var textInTheFile: String? // Declare as optional
    
    if fileManager.fileExists(atPath: fullPathToFile) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: fullPathToFile))
            if let string = String(data: data, encoding: .utf8) {
                print("File contents: \(string)")
                textInTheFile = string
            }
        } catch {
            print("Error reading file: \(error)")
        }
    } else {
        print("File does not exist at path: \(fullPathToFile)")
    }
    
    return textInTheFile // Will return nil if the file wasn't read successfully
}




struct ContentView: View {
    @EnvironmentObject var globaldata: GlobalDataModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openWindow) private var openSecondWindow
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    @State private var showPopover = false
    @State private var files: [String] = []
    @State private var showingPopoverSecond = false
    @State private var alertMessage = ""
    @State private var selectedFileId: String? = nil
    @AppStorage("documents") private var docuemntsONMac: String = ""
    @State private var customUserExportPath: String = ""
    @State private var showingAlert = false
    @State private var filename = "Filename"
    @State private var showFileChooser = false
    
    
    @State var fileNameToImport = "";
    
    @Binding var isFileWindowVisible: Bool
    
    @State private var timer: Timer?
    
    
    //probably we need a file to have new file names all the time so it will be global
    @State private var newFileName: String = "";
    
    // indicate alert state
    @State private var showRenameFileAlert = false
    
    
    @State private var windowStatus: String = "Inactive"
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Welcome to SXMac")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .onAppear{
                            
                            
                            if let versionPointer = checkSupport() {  // checkSupport returns UnsafePointer<CChar>?
                                // Convert UnsafePointer<CChar> to Swift String and assign it to globalData.version
                                globaldata.version = String(cString: versionPointer)
                                print(globaldata.version)  // Prints the version string, e.g., "Running on Mac OS X 14.6.1 (Supported)"
                            } else {
                                globaldata.version = "Error obtaining version"
                                print(globaldata.version)  // Prints "Error obtaining version"
                            }
                            
                            
                            startFileMonitoring()
                            
                            let pathsManager = pathsManager()
                            let folder = pathsManager.filesLocationOnMac()
                            print("\(folder) is here")
                            files = pathsManager.fileListed(onTheLocation: folder)
                        }
                        .onDisappear {
                                   // Invalidate the timer when the view disappears
                                   timer?.invalidate()
                               }
                    
                
                    
                    
                    Image(systemName: "eye")
                        .font(.system(size: 40))
                }
                Text(globaldata.filePathed)
                    .font(.system(size: 9))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading)
            .padding(.top)
            
            List {
                ForEach(files, id: \.self) { file in
                    Button(action: {
                        selectedFileId = file
                        showingPopoverSecond = true
                        
                        let pathsManager = pathsManager()
                        let fullPAthedToFiles = pathsManager.filesLocationOnMac()
                        
                        print("helllo bruh")
                        print(file)
                        
                        let fileURL = URL(fileURLWithPath: file)

                        let fileExtension = fileURL.pathExtension //get the extesnion
                        
                 
                        
                        switch fileExtension {
                        case "md":
                            print("md")
                            globaldata.language = .markdown

                        case "actionscript":
                            print("actionscript")
                            globaldata.language = .actionscript

                        case "ada":
                            print("ada")
                            globaldata.language = .ada

                        case "apache":
                            print("apache")
                            globaldata.language = .apache

                        case "applescript":
                            print("applescript")
                            globaldata.language = .applescript

                        case "bash":
                            print("bash")
                            globaldata.language = .bash

                        case "basic":
                            print("basic")
                            globaldata.language = .basic

                        case "brainfuck":
                            print("brainfuck")
                            globaldata.language = .brainfuck

                        case "c":
                            print("c")
                            globaldata.language = .c

                        case "cpp":
                            print("cpp")
                            globaldata.language = .cpp

                        case "cs":
                            print("cs")
                            globaldata.language = .cs

                        case "css":
                            print("css")
                            globaldata.language = .css

                        case "diff":
                            print("diff")
                            globaldata.language = .diff

                        case "dockerfile":
                            print("dockerfile")
                            globaldata.language = .dockerfile

                        case "go":
                            print("go")
                            globaldata.language = .go

                        case "http":
                            print("http")
                            globaldata.language = .http

                        case "java":
                            print("java")
                            globaldata.language = .java

                        case "javascript":
                            print("javascript")
                            globaldata.language = .javascript

                        case "json":
                            print("json")
                            globaldata.language = .json

                        case "lua":
                            print("lua")
                            globaldata.language = .lua

                        case "markdown":
                            print("markdown")
                            globaldata.language = .markdown

                        case "makefile":
                            print("makefile")
                            globaldata.language = .makefile

                        case "nginx":
                            print("nginx")
                            globaldata.language = .nginx

                        case "objectivec":
                            print("objectivec")
                            globaldata.language = .objectivec

                        case "pgsql":
                            print("pgsql")
                            globaldata.language = .pgsql

                        case "php":
                            print("php")
                            globaldata.language = .php

                        case "python":
                            print("python")
                            globaldata.language = .python

                        case "ruby":
                            print("ruby")
                            globaldata.language = .ruby

                        case "rust":
                            print("rust")
                            globaldata.language = .rust

                        case "shell":
                            print("shell")
                            globaldata.language = .shell

                        case "smalltalk":
                            print("smalltalk")
                            globaldata.language = .smalltalk

                        case "sql":
                            print("sql")
                            globaldata.language = .sql

                        case "swift":
                            print("swift")
                            globaldata.language = .swift

                        case "tcl":
                            print("tcl")
                            globaldata.language = .tcl

                        case "tex":
                            print("tex")
                            globaldata.language = .tex

                        case "twig":
                            print("twig")
                            globaldata.language = .twig

                        case "typescript":
                            print("typescript")
                            globaldata.language = .typescript

                        case "vbnet":
                            print("vbnet")
                            globaldata.language = .vbnet

                        case "vbscript":
                            print("vbscript")
                            globaldata.language = .vbscript

                        case "xml":
                            print("xml")
                            globaldata.language = .xml

                        case "yaml":
                            print("yaml")
                            globaldata.language = .yaml

                        default:
                            print("Could not find extension, manually select the needed default extension")
                            globaldata.language = .markdown // Default to markdown if not found
                        }

                        
                        let contentsWrapped: String? = openTextEditor(fileNameToEdit: file)
                        
                        globaldata.contentsOfFileGlobal = contentsWrapped ?? "error"
                        
                        globaldata.filePathed = fullPAthedToFiles + "/" + file
                        
                        openWindow(id: "third-window")
                    }) {
                        Text(file)
                           
                    }
                    .buttonStyle(PlainButtonStyle())
                    .contextMenu {
                        
                        
                        Button {
                            print("Renaming file now")
                            let alert = alertView()
                            newFileName = alert.promptForFileName()
                            print(newFileName)
                            
                            renamingfile(file, _newFile: newFileName)
                            
                        } label: {
                            Text("Rename file")
                            
                        }
                        .alert("Enter new name", isPresented: $showingAlert) {
                            TextField("Input the final choice", text: $newFileName)
                                 Button("Finish", action: submit)
                             } message: {
                                 Text("Changing the file name")
                             }
                        
                        
                        Button(action: {
                           
                            let pasteboard = NSPasteboard.general
                                          pasteboard.clearContents()
                                          pasteboard.setString(file, forType: .string)
                            
                            
                        }) {
                            
                           Text("Copy name")
                            
                        }
                        
                        
                        Button(action: {
                            
                            
                            
                             let pathManager = pathsManager()
                            
                            let fullPAthedToFiles = pathManager.filesLocationOnMac()
                            
                            globaldata.filePathed = fullPAthedToFiles + "/" + file
                             
                             if globaldata.settingsExportPath == "" {
                                 docuemntsONMac = pathManager.locateDocumentsFolder()
                                 print("THIIIs\(file)")
                                
                                
                                 pathManager.exportSelectedFile(globaldata.filePathed, to: docuemntsONMac)
                                 alertMessage = "File exported to Documents folder successfully."
                             } else {
                                 pathManager.exportSelectedFile(globaldata.filePathed, to: globaldata.settingsExportPath)
                                 alertMessage = "File exported to custom path successfully."
                             }
                             
                             if let index = files.firstIndex(of: file) {
                                 files.remove(at: index)
                                 print("\(file) was removed. Updated array: \(files)")
                             } else {
                                 print("\(file) not found in the array.")
                             }

                             
                             
                             let alertView = alertView()
                             alertView.showAlert(withMessage: alertMessage)
                            
                            
                        }) {
                            
                           Text("Export file")
                            
                        }
                        Button(action: {
                            deleteFile(file)
                        }) {
                            Text("Delete")
                        }
                    }
               /*     .popover(isPresented: $showingPopoverSecond) {
                        if selectedFileId == file {
                            VStack {
                                Button(action: {
                                   
                                    let pathManager = pathsManager()
                                    
                                    if globaldata.settingsExportPath == "" {
                                        docuemntsONMac = pathManager.locateDocumentsFolder()
                                        print(file)
                                        pathManager.exportSelectedFile(globaldata.filePathed, to: docuemntsONMac)
                                        alertMessage = "File exported to Documents folder successfully."
                                    } else {
                                        pathManager.exportSelectedFile(globaldata.filePathed, to: globaldata.settingsExportPath)
                                        alertMessage = "File exported to custom path successfully."
                                    }
                                    
                                    if let index = files.firstIndex(of: file) {
                                        files.remove(at: index)
                                        print("\(file) was removed. Updated array: \(files)")
                                    } else {
                                        print("\(file) not found in the array.")
                                    }

                                    
                                    
                                    let alertView = alertView()
                                    alertView.showAlert(withMessage: alertMessage)
                                }) {
                                    Image(systemName: "square.and.arrow.up.on.square")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text(file)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                            .padding(20)
                            .frame(width: 300, height: 250)
                        }
                    } */
                    
                    Divider()
                    
                    
                }
            }
            
            
            HStack {
                Button {
                    print("Settings entered")
                    openWindow(id: "second-window")
                } label: {
                    Image(systemName: "info.bubble")
                }
                
                Link(destination: URL(string: "https://t.me/Evan_Matthew")!) {
                    Text("By Evan Matthew")
                }
                .font(.system(size: 10))
                
                Link(destination: URL(string: "https://github.com/IvanKoskov")!) {
                    Image("git")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                .font(.system(size: 10))
                
                Spacer()
                
                
                Button {
                    
                    openWindow(id: "drag-window")

                } label: {
                    Image(systemName: "eyedropper")
                }
                
                Button {
                    
                    let pathsManager = pathsManager()
                    let folder = pathsManager.filesLocationOnMac()
                    print("\(folder) is here")
                    files = pathsManager.fileListed(onTheLocation: folder)
                    
                } label: {
                    Image(systemName: "gear.circle")
                }
                
                
                Button {
                    isFileWindowVisible = true
                    openWindow(id: "file-window")
                    
                    
                } label: {
                    Image(systemName: "folder.badge.plus")
                }
                
                Button {
                    let alertView = alertView()
                    var helpMessage: String = """
In order to delete files directly hold the file in the list with two fingers on touch pad or use left click hold on your magic mouse.

If you want to export by the way just click open the needed file and just tap the share icon on the pop menu!
"""
                    alertView.showhelphMessage(helpMessage)             } label: {
                    Image(systemName: "xmark.bin")
                }

               
                Button {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        if let fileURL = panel.url {
                            // Get the full path to the file
                            fileNameToImport = fileURL.path
                            // Get the short name (file name only)
                            let shortFileName = fileURL.lastPathComponent

                            print("Full path: \(fileNameToImport)")
                            print("Short name: \(shortFileName)")

                            // Now you can use both
                            files.append(shortFileName)
                            
                            let pathsManager = pathsManager()
                            pathsManager.importFile(toTheApp: fileNameToImport)

                            // You can store the short name separately if needed
                            // For example, you can store it in another array or variable if required
                        } else {
                            self.filename = "<none>"
                        }
                    }
                } label: {
                    Image(systemName: "plus.magnifyingglass")
                }

                
            }
            .padding()
        }
        .onAppear {
            if true {
                showPopover = true
                isFirstLaunch = false
            }
        }
        .popover(isPresented: $showPopover) {
            Text("You can!")
                .font(.title)
                .padding()
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit markdown file")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "eye.fill")
                        Text("Clearly preview the changes")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share & Export")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    Button("Got it!") {
                        let pathsManager = pathsManager()
                        let folder = pathsManager.filesLocationOnMac()
                        print("\(folder) is here")
                        files = pathsManager.fileListed(onTheLocation: folder)
                        showPopover = false
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .buttonBorderShape(.capsule)
                    .font(.system(size: 15))
                }
                
                VStack {
                    HStack {
                        Image(systemName: "filemenu.and.selection")
                        Text("Easily find from files")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Image(systemName: "bolt")
                        Text("And more")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .padding(.top, -60)
            }
            .padding()
            .frame(width: 510, height: 300)
        }
        
    }
    
    private func deleteFile(_ file: String) {
        print("deleteFile called for file: \(file)")
        if let index = files.firstIndex(of: file) {
            files.remove(at: index)
            print("File removed from list: \(file)")
            let pathsManager = pathsManager()
            pathsManager.deleteTheFile(file)
            
        } else {
            print("File \(file) not found in list.")
        }
    }
    
    private func renamingfile(_ file: String, _newFile: String) {
        
    //deprecated most likely in future update
        
        print("Renaming this : \(file)")
        if let index = files.firstIndex(of: file) {
            files.remove(at: index)
            print("Old file removed from list: \(file)")
            
            let pathsManager = pathsManager()
            var pathtoFiles: String = pathsManager.filesLocationOnMac()
            var result: Bool =  pathsManager.renameFile(atLocation: _newFile, andAlso: pathtoFiles, andOld: file)
            print("Renamed file FINAL \(result)")
            
            
        } else {
            print("File \(file) not found in list.")
        }
    }
    
    
    
    private func startFileMonitoring() {
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                checkForNewFiles()
            }
        }

    private func checkForNewFiles() {
        let pathsManager = pathsManager()
        let folderPath = pathsManager.filesLocationOnMac()  // Assuming this returns a string
        let folderURL = URL(fileURLWithPath: folderPath)  // Convert string to URL
        let fileManager = FileManager.default
        
        do {
            // Get all files in the folder
            let allFiles = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)

            // Convert file URLs to file names (e.g., "file.txt", "image.jpg")
            let fileNames = allFiles.map { $0.lastPathComponent }

            // Compare with previously stored files to find new ones
            let newFiles = fileNames.filter { !files.contains($0) }
            if !newFiles.isEmpty {
                files.append(contentsOf: newFiles)  // Append new files to the list
                print("New files added: \(newFiles)")  // Print new files for debugging
            }

        } catch {
            print("Failed to read contents of directory: \(error)")
        }
    }
    
    private func submit() {
        
        //deprecated
        
    }



}
