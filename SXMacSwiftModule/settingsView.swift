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
    
    @EnvironmentObject var globaldata: GlobalDataModel
    
    @State var versionSettings: String
    
    @EnvironmentObject var gradientManager: GradientThemeManager

    

    
    @State private var options = [
        infosettings(nameOFoption: "App files", descriptionText: "/user/documents/SXMacFiles..."),
        infosettings(nameOFoption: "Version", descriptionText: "2.0.2 alpha"),
        infosettings(nameOFoption: "Color scheme", descriptionText: "Deep shallow Ocean"),
        infosettings(nameOFoption: "Supported formats", descriptionText: ".md & other markdown"),
        infosettings(nameOFoption: "LICENSE", descriptionText: " Creative Commons Attribution-NonCommercial 4.0 International")
        
    ]
    
    
    
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
                    .onAppear{
                        
                        versionSettings = globaldata.version
                    }
                
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
                    Text("Available custom themes")
                        .fontWeight(.bold)
                    Spacer()
                    Picker("", selection: $globaldata.theme) {
                        ForEach(gradientManager.themes) { theme in
                            Text(theme.name)
                                .tag(theme.gradient)  // Use .tag() to bind the gradient instead of the whole theme
                        }
                    }.onChange(of: globaldata.theme) { newValue in
                        // Find the selected theme using the selected gradient
                        if let selectedTheme = gradientManager.themes.first(where: { $0.gradient == newValue }) {
                            print(selectedTheme.name)
                            let pathsManager = pathsManager()
                            let pathToUpdate = pathsManager.createGradientFolderAndFileInside()
                            pathsManager.saveTheNewText(toThefile: pathToUpdate, and: selectedTheme.name)
                        }
                    }
                  
                    
                    
                    
                    
                }
                .padding() // Add padding to each row
                .background(Color.clear) // Ensure no background for the rows
                
                Divider()
                
                HStack {
                    Text("OS support Status")
                        .fontWeight(.bold)
                    Spacer()
                    Text(versionSettings)
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
                    
                    HStack {
                        Text("Web page developer & various contributions")
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding()
                    
                    Divider()
                    
                    HStack {
                        Image("tson")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                            .shadow(color: .gray, radius: 10, x: 0, y: 5)
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("TS0NW0RK")
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("Contributor, web dev, promoter, advertiser")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 12)
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
