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
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Welcome to SXMac")
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                    
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
                        let contentsWrapped: String? = openTextEditor(fileNameToEdit: file)
                        
                        globaldata.contentsOfFileGlobal = contentsWrapped ?? "error"
                        
                        globaldata.filePathed = fullPAthedToFiles + "/" + file
                        
                        openWindow(id: "third-window")
                    }) {
                        Text(file)
                    }
                    .contextMenu {
                        Button(action: {
                            deleteFile(file)
                        }) {
                            Text("Delete")
                        }
                    }
                    .popover(isPresented: $showingPopoverSecond) {
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
                    }
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
                    let alertView = alertView()
                    var helpMessage: String = """
In order to delete files directly hold the file in the list with two fingers on touch pad or use left click hold on your magic mouse.

If you want to export by the way just click open the needed file and just tap the share icon on the pop menu!
"""
                    alertView.showhelphMessage(helpMessage)
                } label: {
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

}
