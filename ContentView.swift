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

    @State private var selectedFileId: String? = nil
    
    
    @AppStorage("documents") private var docuemntsONMac: String = "";
    
    @State private var customUserExportPath: String = "";
    
   
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
            
     
                            
            List(files, id: \.self) { file in
                Button (file){
                    selectedFileId = file
                    showingPopoverSecond = true
                    
                    let pathsManager = pathsManager()
                    var fullPAthedToFiles = pathsManager.filesLocationOnMac()
                    
                    
                    print("helllo bruh")
                    var contentsWrapped: String? = openTextEditor(fileNameToEdit: file)
                    
                      globaldata.contentsOfFileGlobal = contentsWrapped ?? "error"
                        
                    globaldata.filePathed = fullPAthedToFiles + "/" + file
                    
                    openWindow(id: "third-window")
                    
                }   .popover(isPresented: $showingPopoverSecond) {
                    if selectedFileId == file { // Only show popover for the selected file
                        VStack {
                            
                            
                           
                       
                            Button(action: {
                                
                                let pathManager = pathsManager()
                                
                                if (globaldata.settingsExportPath == "") {
                                    
                                    docuemntsONMac = pathManager.locateDocumentsFolder();
                                   
                                    print(file)
                                    pathManager.exportSelectedFile(globaldata.filePathed, to: docuemntsONMac)
                                    
                                } else {
                                    
                                    pathManager.exportSelectedFile(globaldata.filePathed, to: globaldata.settingsExportPath)
                                    
                                }
                                
                                
                             
                             
                                
                            }) {
                                Image(systemName: "square.and.arrow.up.on.square")
                                    .resizable() // Make the image resizable
                                    .scaledToFit() // Maintain aspect ratio
                                    .frame(width: 100, height: 100) // Set the size of the image
                                    // Change the color of the image (if desired)
                            }
                            // Removes any button styling (no background)

                        
                     
                            
                            
                            Text(file)
                                .font(.title) // Increase font size
                                .fontWeight(.bold) // Make the font bold
                                .padding()
                                .foregroundColor(.primary) // Set text color (optional)
                            
                            
                          
                            
                        }
                        .padding(20) // Add extra padding around the content
                        .frame(width: 300, height: 250) // Set the size of the popover's content
                    }
                }

               // .frame(width: 100, height: 100)
                
                
                           //Text(file)
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
                .font(.system(size: 10)) // Use a small positive font size
                
            
                Link(destination: URL(string: "https://github.com/IvanKoskov")!) {
                    Image("git")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20) // You can adjust the frame size for the image
                }
                .font(.system(size: 10)) // Use a small positive font size


               
            }
            
            Spacer()
            
        }
        .onAppear {
            // Check if it's the first launch, then show the popover
            if true {    // if isFirstLaunch
             showPopover = true
               // After showing the popover, set isFirstLaunch to false
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
                    
                    HStack{
                        Image(systemName: "pencil")
                        Text("Edit markdown file")
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "eye.fill")
                        Text("Clearly preview the changes")
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
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
                        showPopover = false // Close the popover when tapped
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .buttonBorderShape(.capsule)
                    .font(.system(size: 15))
                    
                }
                
                
                
                
                VStack {
                    
                    HStack{
                        Image(systemName: "filemenu.and.selection")
                        Text("Easily find from files")
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
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
}

