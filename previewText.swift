//
//  previewText.swift
//  SXMac
//
//  Created by Evan Matthew on 11/3/2568 BE.
//
import Markdown
import SwiftUI



struct previewText: View {
    
    @EnvironmentObject var globaldata: GlobalDataModel
    
    var body: some View {
        Markdown(content: $globaldata.contentsOfFileGlobal)
        Text("hiu")
    }
}

