//
//  SXMacApp.swift
//  SXMac
//
//  Created by Evan Matthew on 09/03/2025 
//



/*

 
   ______  __ __  ___
  / ___/ |/ //  |/  /___ ______
  \__ \|   // /|_/ / __ `/ ___/
  ___/ /   / /  / / /_/ / /__
/____/_/|_/_/  /_/\__,_/\___/

 By Ivan Koskov (Evan Matthew)
 
 SXMac © 2025 by Ivan Koskov (aka Evan Matthew) is licensed under Creative Commons Attribution-NonCommercial 4.0 International Public License

*/

import SwiftUI
import CodeEditor //for variable

class GlobalDataModel: ObservableObject {
    @Published var filePathed: String = "blank"
    @Published var contentsOfFileGlobal: String = "BLANK"
    @Published var settingsExportPath: String = "";
    @Published var language = CodeEditor.Language.markdown
}

    

@main
struct SXMacApp: App {
    @StateObject private var globaldata = GlobalDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globaldata)
                .frame(width: 400, height: 400)
                .fixedSize()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .black, .blue]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        
        Window("SXMac settings", id: "second-window") { // Define the second window with an ID
            settingsView()
                .environmentObject(globaldata)
                .frame(width: 600, height: 500)
                .fixedSize()
                .background(LinearGradient(gradient: Gradient(colors: [.cyan, .blue, .gray]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        
        
        Window("SXMac MarkDown", id: "third-window") { // Define the second window with an ID
            textEditView()
                .environmentObject(globaldata)
                .frame(width: 600, height: 500)
                .fixedSize()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .gray]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        Window("SXMac MarkDown", id: "fourth-window") { // Define the second window with an ID
            languagesView()
                .environmentObject(globaldata)
                .frame(width: 600, height: 500)
                .fixedSize()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .blue]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        Window("SXMac MarkDown", id: "preview-window") { // Define the second window with an ID
            previewText()
                .environmentObject(globaldata)
                .frame(width: 700, height: 600)
                .fixedSize()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray, .blue]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        
        
    }
}



//resizing stuff here
extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        if #available(macOS 13.0, *) {
            return windowResizability(.contentSize)
        } else {
            return self
        }
    }
}
