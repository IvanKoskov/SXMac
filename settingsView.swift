//
//  settingsView.swift
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025 
//

import SwiftUI
import CodeEditor

struct infosettings: Identifiable {
    var id = UUID() // Conforming to Identifiable
    var nameOFoption: String
    var descriptionText: String
}

struct settingsView: View {
    @State private var options = [
        infosettings(nameOFoption: "App files", descriptionText: "/user/documents/SXMacFiles..."),
        infosettings(nameOFoption: "Version", descriptionText: "2.0.0 alpha"),
        infosettings(nameOFoption: "Color scheme", descriptionText: "Deep shallow Ocean"),
        infosettings(nameOFoption: "Supported formats", descriptionText: ".md & other markdown"),
        infosettings(nameOFoption: "LICENSE", descriptionText: " Creative Commons Attribution-NonCommercial 4.0 International")
        
    ]
    
    @EnvironmentObject var globaldata: GlobalDataModel
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                Image("icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 120,maxHeight: 120, alignment: .center)
                    .font(.system(size: 10))
                    .shadow(color: .gray, radius: 35, x: 0, y: 2)
                
                // Zero spacing to make rows adjacent to each other
                ForEach(options) { option in
                    HStack {
                        Text(option.nameOFoption)
                            .fontWeight(.bold)
                        Spacer()
                        Text(option.descriptionText)
                            .foregroundColor(.white)
                    }
                    .padding() // Add padding to each row
                    .background(Color.clear) // Ensure no background for the rows
                    
                    Divider() // Separator between rows
                }
                
                HStack {
                    Text("Export custom path")
                        .fontWeight(.bold)
                    Spacer()
                    TextField("Enter custom export path", text: $globaldata.settingsExportPath)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding() // Add padding to each row
                .background(Color.clear) // Ensure no background for the rows
                
                Divider()
                
                
                HStack {
                    Text("Available languages & Mardown picker")
                        .fontWeight(.bold)
                    Spacer()
                    Picker("", selection: $globaldata.language) {
                               ForEach(CodeEditor.availableLanguages) { language in
                                   Text("\(language.rawValue.capitalized)")
                                       .tag(language)
                               }
                           }
                }
                .padding() // Add padding to each row
                .background(Color.clear) // Ensure no background for the rows
                
                Divider()
                
                
                
                HStack {
                    Text("Available languages & Mardown")
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        print("Lanaguages displayed")
                        openWindow(id: "fourth-window")
                    } label: {
                        Image(systemName: "questionmark.folder")
                    }
                }
                .padding() // Add padding to each row
                .background(Color.clear) // Ensure no background for the rows
                
                Divider()
                
                VStack {
                    // Title Section
                    HStack {
                        Text("Developers & Contributors")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()

                    Divider()

                    // First Developer Section
                    HStack {
                        Image("evan")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 4) // Border
                            )
                            .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("Evan Matthew")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.leading, -1)
                            
                            Text("Main developer, UI designer and maintainer")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                    
                    Divider()
                    
                    // Second Developer Section (Fixing alignment here)
                    HStack {
                        Image("referencedev")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("buenos aires")
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("Contributor, various help and co-owner")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 30)
                        .frame(maxWidth: .infinity, alignment: .trailing) // Ensure alignment is to the left
                    }
                    .padding()
                    
                    Divider()
                    
                    // Special Thanks Section
                    HStack {
                        Text("Special thanks")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    
                    Divider()
                    
                    // Special Contributor Section
                    HStack {
                        Image("reference")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("ZeeZide")
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("CodeEditor, editor view, languages and other")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                }
                .background(Color.clear)

                
            }
            .padding()
            
        }
    }
}
