//
//  textEditView.swift
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025 
//


//the general view for editing the markdown files in SXMac



import SwiftUI
import CodeEditor

struct textEditView: View {
    
    @Environment(\.openWindow) private var openWindow
    
    @EnvironmentObject var globalfile: GlobalDataModel  // Access environment object and etc
    @State private var showingTextMenu: Bool = false
   // @State private var language = CodeEditor.Language.markdown //default
    
    @State private var showingSecondTextMenu: Bool = false
    
    var body: some View {
        VStack {
            if (true) {
                
                
            }
            CodeEditor(source: $globalfile.contentsOfFileGlobal, language: globalfile.language, theme: .ocean) // Bind to the environment object???? this is custom textView from CodeEditor library
                .frame(minWidth: 600, minHeight: 500)  // Specify frame size
                .padding()
                .onAppear {
                    // Optionally perform actions when the view appears
                }
                .toolbar {
                    // Set the window title for macOS
                    ToolbarItem(placement: .principal) {
                        Button("SXMac editing \(globalfile.filePathed)") {
                            showingTextMenu = true
                        }
                        .font(.headline)
                        .popover(isPresented: $showingTextMenu) {
                            VStack {
                                ScrollView {
                                    VStack(spacing: 16) {
                                        HStack {
                                            Text("Save changes now")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button("Save") {
                                                let pathsManager = pathsManager()
                                                var logResult: Bool =  pathsManager.saveTheNewText(toThefile: globalfile.filePathed, and: globalfile.contentsOfFileGlobal)
                                                print(logResult)
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear) // Ensure no background for the rows
                                        
                                        Divider() // Separator between rows
                                        
                                        HStack {
                                            Text("Discard changes")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button("Close editor") {
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("Markdown viewer")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button("Preview") {
                                                print(globalfile.contentsOfFileGlobal)
                                                openWindow(id: "preview-window")
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("Web Preview")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button("Render") {
                                                print(globalfile.contentsOfFileGlobal)
                                                openWindow(id: "web-window")
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        
                                        
                                      
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("Other & Help")
                                                .fontWeight(.bold)
                                            Spacer()
                                            
                                            Button(action: {
                                                print(CodeEditor.availableLanguages)
                                                print(CodeEditor.availableThemes)
                                                showingSecondTextMenu = true
                                            }) {
                                                Image(systemName: "gear")
                                                    .imageScale(.large) // You can customize the image size here if needed
                                            }
                                            .popover(isPresented: $showingSecondTextMenu) {
                                                ScrollView {
                                                    
                                                    
                                                    VStack{
                                                        
                                                        
                                                        HStack {
                                                            Text("To change highlight go to settings")
                                                                .fontWeight(.bold)
                                                          
                                                        }
                                                        .padding()
                                                        .background(Color.clear)
                                                        
                                                        Divider()
                                                        
                                                        HStack {
                                                            Text("To apply reopen the file from menu")
                                                                .bold()
                                        
                                                        
                                                        }
                                                        .padding()
                                                        .background(Color.clear)
                                                    
                                                    
                                                        
                                                    }
                                                    .padding(.top, 10)
                                                    .frame(width: 200, height: 200)
                                                }
                                            }
                                            
                                            
                                        }
                                        .padding()
                                        .background(Color.clear)

                                        Divider()

                                        HStack {
                                            Text("Quit")
                                                .fontWeight(.bold)
                                            Spacer()
                                            Button("Close Md manager") {
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("UI by Evan Matthew ♡")
                                                .padding()
                                                .font(.system(size: 11))
                                                .italic()
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                        }
                                        
                                        
                                        
                                        
                                    }
                                }
                                .frame(width: 300, height: 200) // Fixed size for the popover
                            }
                        }
                    }
                }
        }
    }
}
