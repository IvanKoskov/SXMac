//
//  settingsView.swift
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025 
//

import SwiftUI

struct infosettings: Identifiable {
    var id = UUID() // Conforming to Identifiable
    var nameOFoption: String
    var descriptionText: String
}

struct settingsView: View {
    @State private var options = [
        infosettings(nameOFoption: "App files", descriptionText: "/user/documents/SXMacFiles..."),
        infosettings(nameOFoption: "Version", descriptionText: "1.0.1 alpha"),
        infosettings(nameOFoption: "Color scheme", descriptionText: "Deep shallow Ocean"),
        infosettings(nameOFoption: "Supported formats", descriptionText: ".md & other markdown"),
        infosettings(nameOFoption: "LICENSE", descriptionText: " Creative Commons Attribution-NonCommercial 4.0 International")
        
    ]
    
    @EnvironmentObject var globaldata: GlobalDataModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image("icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .center)
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
            
        }
        .padding()
    }
}
