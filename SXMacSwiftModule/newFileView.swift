//
//  newFileView.swift
//  SXMac
//
//  Created by Evan Matthew on 12/3/2568 BE.
//

import SwiftUI

struct newFileView: View {
    
    @EnvironmentObject var globaldata: GlobalDataModel
    @State private var userCreatedFile = ""
    @Environment(\.dismiss) var dismiss  // Add dismiss environment
    @Binding var isFileWindowVisible: Bool
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    TextField("```Enter the full desired file```", text: $userCreatedFile)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer()
                    
                    Button {
                        let pathsManager = pathsManager()
                        let folderToSave: String = pathsManager.filesLocationOnMac()
                        let isSuccessed: Bool = pathsManager.createNewFile(userCreatedFile, at: folderToSave)
                        print(isSuccessed)
                        let alert = alertView()
                        
                        if isSuccessed {
                           // alert.showAlert(withMessage: "File \(userCreatedFile) is created at the path \(folderToSave)")
                         //   isFileWindowVisible = false
                                //   dismiss() // Dismiss the window upon success
                            showAlert = true
                            
                        } else {
                            alert.showAlert(withMessage: "Error creating a file!")
                        }
                    } label: {
                        Text("Add file")
                    }
                    
                    .alert("Provided file is created at the default path of SXMac app without errors", isPresented: $showAlert) {
                               Button("Dismiss", role: .cancel) {
                                   
                                   isFileWindowVisible = false
                                   
                               }
                           }
                    
                    
                    
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("NOTE")
                        .bold()
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    Text("The files are saved to the ```/SXMacFiles``` by default")
                }
                .padding()
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add a new file")
                    .font(.headline)
            }
        }
    }
}
