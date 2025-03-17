//
//  dragDropView.swift
//  SXMac
//
//  Created by Evan Matthew on 17/3/2568 BE.
//

import SwiftUI

struct dragDropView: View {
    
    @EnvironmentObject var globalfile: GlobalDataModel
    
   
    var body: some View {
        VStack {
            Text("Drag and Drop Files Here")
                .font(.title)
                .padding()
            
            // Drag-and-Drop area
            Rectangle()
            
                .fill(Color.gray.opacity(0.2))
                .frame(width: 300, height: 200)
                .cornerRadius(20) 
                .overlay(
                    Text("Drop files here")
                        .foregroundColor(.white)
                        .opacity(0.7)
                )
                .onDrop(of: [.fileURL], isTargeted: nil) { providers in
                    // Handling the drop of files
                    if let item = providers.first {
                        item.loadObject(ofClass: URL.self) { (url, error) in
                            if let url = url as? URL {
                                // Get the full path of the dropped file
                                self.globalfile.droppedFilePath = url.path
                            }
                        }
                    }
                    return true
                }
            
            if let path = globalfile.droppedFilePath {
                Text("File Path: \(path)")
                    .padding()
            } else {
                Text("No file dropped yet.")
                    .padding()
            }
        }
        .padding()
    }
}

