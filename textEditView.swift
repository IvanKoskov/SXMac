//
//  textEditView.swift
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025 
//


//the general view for editing the markdown files in SXMac



import SwiftUI

struct textEditView: View {
    
    @EnvironmentObject var globalfile: GlobalDataModel  // Access environment object
    @State private var showingTextMenu: Bool = false
    
    var body: some View {
        VStack {
            TextEditor(text: $globalfile.contentsOfFileGlobal)  // Bind to the environment object
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
                                                showingTextMenu = false
                                            }
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("Other")
                                                .fontWeight(.bold)
                                            Spacer()
                                            
                                            Button(action: {
                                                showingTextMenu = false
                                            }) {
                                                Image(systemName: "gear")
                                                    .imageScale(.large) // You can customize the image size here if needed
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
