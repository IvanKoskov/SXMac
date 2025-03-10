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

    var body: some View {
        VStack {
            TextEditor(text: $globalfile.contentsOfFileGlobal)  // Bind to the environment object
                .frame(width: 600, height: 500)  // Specify frame size
                .padding()
        }
    }
}
