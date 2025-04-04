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
import FramelessWindow // custom windows


struct VisualEffect: NSViewRepresentable {
   func makeNSView(context: Self.Context) -> NSView { return NSVisualEffectView() }
   func updateNSView(_ nsView: NSView, context: Context) { }
}

//delegate to make custom app bar option
class AppDelegate: NSObject, NSApplicationDelegate {
    private var aboutBoxWindowController: NSWindowController?

    func showAboutPanel() {
        if aboutBoxWindowController == nil {
            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
            let window = NSWindow()
            window.styleMask = styleMask
            window.title = "SXMac editor"
            window.contentView = NSHostingView(rootView: AboutView())
            aboutBoxWindowController = NSWindowController(window: window)
        }

        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }
}



class GlobalDataModel: ObservableObject {
    
    
    @Published var filePathed: String = "blank"
    @Published var contentsOfFileGlobal: String = "BLANK"
    @Published var settingsExportPath: String = "";
    @Published var language = CodeEditor.Language.markdown
    @Published var droppedFilePath: String?
    @Published var version: String = "Not obtained";
    @Published var theme: Gradient =  Gradient(colors: [.blue]) //persisted


}



    

@main
struct SXMacApp: App {
    @State private var pinnedWindow: NSWindow?
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var globaldata = GlobalDataModel()
    @State private var isFileWindowVisible = true
    @StateObject var gradientManager = GradientThemeManager()
    var body: some Scene {
        WindowGroup {
            ContentView(isFileWindowVisible: $isFileWindowVisible)
                .environmentObject(globaldata)
                .environmentObject(gradientManager)
              //  .frame(width: 400, height: 400)
              //  .fixedSize()
           // .background(LinearGradient(gradient: Gradient(colors: [.blue, .black, .blue]), startPoint: .top, endPoint: .bottom))
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
                .listStyle(.sidebar)
            
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.appInfo) {
                Button(action: {
                    appDelegate.showAboutPanel()
                }) {
                    Text("SXMac rich editor")
                }
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle()) 
        .windowResizabilityContentSize()
        
        Window("SXMac settings", id: "second-window") { // Define the second window with an ID
            settingsView(versionSettings: "error")
                .environmentObject(globaldata)
                .environmentObject(gradientManager)
              //  .frame(width: 600, height: 500)
              //  .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
              //  .background(LinearGradient(gradient: Gradient(colors: [.cyan, .blue, .gray]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        
        
        Window("SXMac MarkDown", id: "third-window") { // Define the second window with an ID
            textEditView()
                .environmentObject(globaldata)
             //   .frame(width: 600, height: 500)
           //     .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
              //  .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .gray]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        
        
        Window("SXMac Editor Alpha", id: "betaeditor-window") { // Define the second window with an ID
            TabFilesView()
             /*   .onAppear {
                                 // Access the window after it appears
                                 if let window = NSApplication.shared.windows.first {
                                     // Set the window to stay on top (if it's the window you want)
                                     window.level = .floating
                                 }
                             }
              */
            
                .onAppear {
                                   setWindowToStayOnTop(windowID: "betaeditor-window")
                               }
            
                .environmentObject(globaldata)
             //   .frame(width: 600, height: 500)
           //     .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
              //  .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .gray]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        
        
        
        Window("SXMac MarkDown", id: "fourth-window") { // Define the second window with an ID
            languagesView()
                .environmentObject(globaldata)
              //  .frame(width: 600, height: 500)
              //  .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
              //  .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .blue]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        Window("SXMac MarkDown", id: "preview-window") { // Define the second window with an ID
            previewText()
                .environmentObject(globaldata)
             //   .frame(width: 700, height: 600)
            //    .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .top, endPoint: .bottom))
               // .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray, .blue]), startPoint: .top, endPoint: .bottom))
        }
        .windowResizabilityContentSize()
        .windowStyle(HiddenTitleBarWindowStyle()) // Optional: Hide title bar for second window
        
        Window("SXMac MarkDown", id: "file-window") {
                    if isFileWindowVisible {
                        newFileView( isFileWindowVisible: $isFileWindowVisible)
                       
                            .environmentObject(globaldata)
                            .frame(width: 450, height: 150)
                            .fixedSize()
                            .background(LinearGradient(gradient: globaldata.theme, startPoint: .topLeading, endPoint: .bottomTrailing))
                           // .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    }
                }
                .windowResizabilityContentSize()
                .windowStyle(HiddenTitleBarWindowStyle())
        
        Window(globaldata.filePathed, id: "web-window") {
            
            webPreviewView()
                .environmentObject(globaldata)
                .frame(width: 700, height: 600)
                .fixedSize()
                .background(LinearGradient(gradient: globaldata.theme, startPoint: .topLeading, endPoint: .bottomTrailing))
              //  .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray, .blue]), startPoint: .top, endPoint: .bottom))
            
        }
        .windowResizabilityContentSize()
    //    .windowStyle(HiddenTitleBarWindowStyle())
        
      
        FramelessWindow("Quick import", id: "drag-window") {
            dragDropView()
                .environmentObject(globaldata)
             //   .frame(width: 400, height: 350)
        
                    .background(VisualEffect())
              //  .fixedSize()
              }
       .windowResizabilityContentSize()
    }
    
    
    
    func setWindowToStayOnTop(windowID: String) {
            // Find the specific window by its ID
            if let window = NSApplication.shared.windows.first(where: { $0.identifier?.rawValue == windowID }) {
                // Set the window to stay on top
                window.level = .floating
            }
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
