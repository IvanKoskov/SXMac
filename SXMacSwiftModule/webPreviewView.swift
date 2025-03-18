//
//  webPreviewView.swift
//  SXMac
//
//  Created by Evan Matthew on 13/3/2568 BE.
//


import SwiftUI
import WebKit
import Cocoa // for macOS apps

// WebView for macOS (NSViewRepresentable instead of UIViewRepresentable)
struct WebView: NSViewRepresentable {
    var htmlContent: String

    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // Load the HTML content into the WebView
        nsView.loadHTMLString(htmlContent, baseURL: nil)
    }
}



// View to display the WebView
struct WebPreviewView: View {
    @EnvironmentObject var globalfile: GlobalDataModel

    var body: some View {
        VStack {
            // Show the WebView with the HTML content from the global model
            WebView(htmlContent: globalfile.contentsOfFileGlobal)
                .edgesIgnoringSafeArea(.all) // Make the WebView take up the whole screen
        }
    }
}

// ContentView with the global data model injected
struct webPreviewView: View {
    @EnvironmentObject var globalfile: GlobalDataModel

    var body: some View {
        
            // Pass the GlobalDataModel as an EnvironmentObject
            WebPreviewView()
                .environmentObject(globalfile)
        
       
            
    }
    
}
