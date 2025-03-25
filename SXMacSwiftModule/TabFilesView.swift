//
//  TabFilesView.swift
//  SXMac
//
//  Created by Evan Matthew on 24/3/2025.
//

import SwiftUI
import CodeEditor

struct TabFilesView: View {
    @State private var textToSearch: String = ""
    @State private var timer: Timer?
    @State private var fileName: String = ""
    @Environment(\.openWindow) private var openWindow
    @State private var showingAlert = false
    @State private var showingTextMenu = false
    @State private var showingSecondTextMenu = false
    @State private var selectedTab = 0
    @State private var tabs: [(name: String, content: String, path: String, language: CodeEditor.Language)] = [] // Added path to track full path
    @State private var lastOpenedFile: String = ""
    
    @EnvironmentObject var globalfile: GlobalDataModel
    
    var body: some View {
        VStack {
            // Tab picker
            Picker("", selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text(tabs[index].name).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Tab content
            TabView(selection: $selectedTab) {
                
                
                
                ForEach(0..<tabs.count, id: \.self) { index in
                    
                    
                    
                    CodeEditor(
                        source: Binding<String>(
                            get: { tabs[index].content },
                            set: { newValue in
                                tabs[index].content = newValue
                                // Update global content when editing the active tab
                                if index == selectedTab {
                                    globalfile.contentsOfFileGlobal = newValue
                                }
                            }
                        ),
                        language: globalfile.language,
                        theme: .ocean
                    )
                    .tag(index)
                }
            }
            .onChange(of: selectedTab) { newTabIndex in
                guard !tabs.isEmpty else { return }
                // Update global state when switching tabs
                globalfile.filePathed = tabs[newTabIndex].path
                globalfile.contentsOfFileGlobal = tabs[newTabIndex].content
                globalfile.language = tabs[newTabIndex].language
                
                
            }
        }
        .onAppear {
            initializeOrUpdateTabs()

        }
        .onChange(of: globalfile.filePathed) { newPath in
            initializeOrUpdateTabs()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button("SXMac editor on \(globalfile.filePathed)") {
                    showingTextMenu = true
                }
                .font(.headline)
                .popover(isPresented: $showingTextMenu) {
                    popoverView
                }
            }
        }
    
    }
    
    private func initializeOrUpdateTabs() {
        let currentFile = URL(fileURLWithPath: globalfile.filePathed).lastPathComponent
        
        // If new file or tabs empty
        if lastOpenedFile != currentFile || tabs.isEmpty {
            let fileName = URL(fileURLWithPath: globalfile.filePathed).lastPathComponent
            let fileExists = tabs.contains { $0.path == globalfile.filePathed }
            
            if !fileExists {
                tabs.removeAll()
                tabs.append((
                    name: fileName,
                    content: globalfile.contentsOfFileGlobal,
                    path: globalfile.filePathed,
                    language: globalfile.language
                ))
                selectedTab = 0
            } else if let index = tabs.firstIndex(where: { $0.path == globalfile.filePathed }) {
                selectedTab = index
            }
            
            lastOpenedFile = fileName
        }
    }
    
    private func addNewTab() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        
        if panel.runModal() == .OK, let fileURL = panel.url {
            let filePath = fileURL.path
             fileName = fileURL.lastPathComponent
            
            // Check if file is already open
            if let existingIndex = tabs.firstIndex(where: { $0.path == filePath }) {
                selectedTab = existingIndex
                return
            }
            
            do {
                let fileContent = try String(contentsOf: fileURL)
                
                
                
                
                
                
                
                
                let fileURL = URL(fileURLWithPath: fileName)

                let fileExtension = fileURL.pathExtension //get the extesnion
                
         
                
                switch fileExtension {
                    case "md":
                        print("md")
                        globalfile.language = .markdown
                        
                    case "actionscript":
                        print("actionscript")
                        globalfile.language = .actionscript
                        
                    case "ada":
                        print("ada")
                        globalfile.language = .ada
                        
                    case "apache":
                        print("apache")
                        globalfile.language = .apache
                        
                    case "applescript":
                        print("applescript")
                        globalfile.language = .applescript
                        
                    case "bash":
                        print("bash")
                        globalfile.language = .bash
                        
                    case "basic":
                        print("basic")
                        globalfile.language = .basic
                        
                    case "brainfuck":
                        print("brainfuck")
                        globalfile.language = .brainfuck
                        
                    case "c":
                        print("c")
                        globalfile.language = .c
                        
                    case "cpp":
                        print("cpp")
                        globalfile.language = .cpp
                        
                    case "cs":
                        print("cs")
                        globalfile.language = .cs
                        
                    case "css":
                        print("css")
                        globalfile.language = .css
                        
                    case "diff":
                        print("diff")
                        globalfile.language = .diff
                        
                    case "dockerfile":
                        print("dockerfile")
                        globalfile.language = .dockerfile
                        
                    case "go":
                        print("go")
                        globalfile.language = .go
                        
                    case "http":
                        print("http")
                        globalfile.language = .http
                        
                    case "java":
                        print("java")
                        globalfile.language = .java
                        
                    case "javascript":
                        print("javascript")
                        globalfile.language = .javascript
                        
                    case "json":
                        print("json")
                        globalfile.language = .json
                        
                    case "lua":
                        print("lua")
                        globalfile.language = .lua
                        
                    case "markdown":
                        print("markdown")
                        globalfile.language = .markdown
                        
                    case "makefile":
                        print("makefile")
                        globalfile.language = .makefile
                        
                    case "nginx":
                        print("nginx")
                        globalfile.language = .nginx
                        
                    case "objectivec":
                        print("objectivec")
                        globalfile.language = .objectivec
                        
                    case "pgsql":
                        print("pgsql")
                        globalfile.language = .pgsql
                        
                    case "php":
                        print("php")
                        globalfile.language = .php
                        
                    case "python":
                        print("python")
                        globalfile.language = .python
                        
                    case "ruby":
                        print("ruby")
                        globalfile.language = .ruby
                        
                    case "rust":
                        print("rust")
                        globalfile.language = .rust
                        
                    case "shell":
                        print("shell")
                        globalfile.language = .shell
                        
                    case "smalltalk":
                        print("smalltalk")
                        globalfile.language = .smalltalk
                        
                    case "sql":
                        print("sql")
                        globalfile.language = .sql
                        
                    case "swift":
                        print("swift")
                        globalfile.language = .swift
                        
                    case "tcl":
                        print("tcl")
                        globalfile.language = .tcl
                        
                    case "tex":
                        print("tex")
                        globalfile.language = .tex
                        
                    case "twig":
                        print("twig")
                        globalfile.language = .twig
                        
                    case "typescript":
                        print("typescript")
                        globalfile.language = .typescript
                        
                    case "vbnet":
                        print("vbnet")
                        globalfile.language = .vbnet
                        
                    case "vbscript":
                        print("vbscript")
                        globalfile.language = .vbscript
                        
                    case "xml":
                        print("xml")
                        globalfile.language = .xml
                        
                    case "yaml":
                        print("yaml")
                        globalfile.language = .yaml
                        
                    default:
                        print("Could not find extension, manually select the needed default extension")
                        globalfile.language = .markdown // Default to markdown if not found
                }

                
                
                
                
                
                
                
                
                
                
                
                tabs.append((
                    name: fileName,
                    content: fileContent,
                    path: filePath,
                    language: globalfile.language
                    
                ))
                
                selectedTab = tabs.count - 1
                globalfile.filePathed = filePath
                globalfile.contentsOfFileGlobal = fileContent
                lastOpenedFile = fileName
            } catch {
                print("Error reading file: \(error)")
                // Handle error (maybe show alert)
            }
        }
    }
    
    private func deleteCurrentTab() {
        guard !tabs.isEmpty else { return }
        
        let deleteTabIndex = selectedTab
        tabs.remove(at: deleteTabIndex)
        
        if tabs.isEmpty {
            selectedTab = 0
            globalfile.filePathed = ""
            globalfile.contentsOfFileGlobal = ""
            lastOpenedFile = ""
        } else {
            selectedTab = min(deleteTabIndex, tabs.count - 1)
            globalfile.filePathed = tabs[selectedTab].path
            globalfile.contentsOfFileGlobal = tabs[selectedTab].content
            lastOpenedFile = tabs[selectedTab].name
        }
    }
    
    private func saveCurrentFile() {
        guard !tabs.isEmpty else { return }
        
        let currentTab = tabs[selectedTab]
        let pathsManager = pathsManager()
        
        do {
            try currentTab.content.write(
                to: URL(fileURLWithPath: currentTab.path),
                atomically: true,
                encoding: .utf8
            )
            print("File saved successfully")
            showingTextMenu = false
        } catch {
            print("Error saving file: \(error)")
            // Handle error (maybe show alert)
        }
    }
    
    // ... [rest of your popoverView code remains the same, but update the save action] ...
    
    private var popoverView: some View {
        ScrollView {
            /*
            TextField(
                 "SXMac editor fast search",
                 text: $textToSearch
             )
            .padding()
             .onSubmit {
                 print("done\(globalfile.contentsOfFileGlobal)")
             }
             */ // in development
           
            Divider()
            
            Button(action: addNewTab) {
                Text("Add file to the Tab")
                    .padding()
                    .foregroundColor(.white)
                    .bold()
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider()
            
            Button(action: deleteCurrentTab) {
                Text("Delete current file Tab")
                    .padding()
                    .foregroundColor(.white)
                    .bold()
                    .frame(alignment: .leading)
            }
            .buttonStyle(PlainButtonStyle())
            
            HStack {
                Text("Save changes now")
                    .fontWeight(.bold)
                Spacer()
                Button("Save") {
                    saveCurrentFile()
                }
            }
            .padding()
            .background(Color.clear)
            
            Divider() // Separator between rows
                        
                        HStack {
                            Text("Discard changes")
                                .fontWeight(.bold)
                            Spacer()
                            Button("Close editor") {
                                showingTextMenu = false
                            }
                        }
                        .padding()
                        .background(Color.clear)
                        
                        Divider()
                        
                        HStack {
                            Text("Markdown viewer")
                                .fontWeight(.bold)
                            Spacer()
                            Button("Preview") {
                                print(globalfile.contentsOfFileGlobal)
                                openWindow(id: "preview-window")
                                showingTextMenu = false
                            }
                        }
                        .padding()
                        .background(Color.clear)
                        
                        
                        Divider()
                        
                        HStack {
                            Text("Web Preview")
                                .fontWeight(.bold)
                            Spacer()
                            Button("Render") {
                                print(globalfile.contentsOfFileGlobal)
                                openWindow(id: "web-window")
                                showingTextMenu = false
                            }
                        }
                        .padding()
                        .background(Color.clear)
                        
                        
                        
                      
                        
                        Divider()
                        
                        HStack {
                            Text("Other & Help")
                                .fontWeight(.bold)
                            Spacer()
                            
                            Button(action: {
                                print(CodeEditor.availableLanguages)
                                print(CodeEditor.availableThemes)
                                showingSecondTextMenu = true
                            }) {
                                Image(systemName: "gear")
                                    .imageScale(.large) // You can customize the image size here if needed
                            }
                            .popover(isPresented: $showingSecondTextMenu) {
                                ScrollView {
                                    
                                    
                                    VStack{
                                        
                                        
                                        HStack {
                                            Text("To change highlight go to settings")
                                                .fontWeight(.bold)
                                          
                                        }
                                        .padding()
                                        .background(Color.clear)
                                        
                                        Divider()
                                        
                                        HStack {
                                            Text("To apply reopen the file from menu")
                                                .bold()
                        
                                        
                                        }
                                        .padding()
                                        .background(Color.clear)
                                    
                                    
                                        
                                    }
                                    .padding(.top, 10)
                                    .frame(width: 200, height: 200)
                                }
                            }
                            
                            
                        }
                        .padding()
                        .background(Color.clear)

                        Divider()

                        HStack {
                            Text("Quit")
                                .fontWeight(.bold)
                            Spacer()
                            Button("Close Md manager") {
                                showingTextMenu = false
                            }
                        }
                        .padding()
                        .background(Color.clear)
                        
                        Divider()
                        
                        HStack {
                            Text("UI by Evan Matthew ♡")
                                .padding()
                                .font(.system(size: 11))
                                .italic()
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        
            
            // ... [rest of your popover code] ...
        }
        .frame(width: 300, height: 113)
    }
    
    
    private func updateLanguage() -> CodeEditor.Language {
        
        let fileURL = URL(fileURLWithPath: globalfile.filePathed)
        
        let fileExtension = fileURL.pathExtension //get the extesnion
        
        switch fileExtension {
        case "md":
            print("md")
            globalfile.language = .markdown
            
        case "actionscript":
            print("cpp")
            globalfile.language = .cpp
            
        default:
            print("Could not find extension, manually select the needed default extension")
          globalfile.language = .markdown // Default to markdown if not found
            
            
            
        }
        return globalfile.language
    }
    
}




/*
struct TabFilesView_Previews: PreviewProvider {
    static var previews: some View {
        TabFilesView()
    }
}
*/



