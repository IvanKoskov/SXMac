//
//  previewText.swift
//  SXMac
//
//  Created by Evan Matthew on 11/3/2568 BE.
//

import Markdown
import SwiftUI

struct previewText: View {
    
    @State private var showingColorMenu: Bool = false
    @State private var bgColor = Color.gray
    
    @EnvironmentObject var globalfile: GlobalDataModel
    
    var body: some View {
        VStack {
            Markdown(content: $globalfile.contentsOfFileGlobal)
                .background(bgColor) // Set background color for the Markdown view
             //   .ignoresSafeArea()
            
            Button("Previews color of \(globalfile.filePathed)") {
                showingColorMenu = true
            }
            .padding()
            .font(.headline)
            .popover(isPresented: $showingColorMenu) {
                ColorPicker("Select Background Color", selection: $bgColor)
                    .padding()
            }
        }
        .toolbar {
            // Set the window title for macOS
            ToolbarItem(placement: .principal) {
                Text("SXMac Previews \(globalfile.filePathed)")
                    .font(.headline)
            }
        }
    }
}

