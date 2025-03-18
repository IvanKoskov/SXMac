//
//  themes.swift
//  SXMac
//
//  Created by Evan Matthew on 18/3/2568 BE.
//

import Foundation
import SwiftUI

// Themes code snippet

/*
 
 не помню как но у меня были такие темы extension GradientTheme {
     static let themes: [GradientTheme] = [
         GradientTheme(name: "Sunset", gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.pink.opacity(0.3)])),
         GradientTheme(name: "Ocean", gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)])),
         GradientTheme(name: "Forest", gradient: Gradient(colors: [Color.green.opacity(0.3), Color.mint.opacity(0.3)])),
         GradientTheme(name: "Lilac Dawn", gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.indigo.opacity(0.3)])),
         GradientTheme(name: "Sandstorm", gradient: Gradient(colors: [Color.brown.opacity(0.3), Color.yellow.opacity(0.3)])),
         GradientTheme(name: "Northern Lights", gradient: Gradient(colors: [Color.cyan.opacity(0.3), Color.green.opacity(0.3)])),
         GradientTheme(name: "Storm Front", gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.blue.opacity(0.3)])),
         GradientTheme(name: "Hot Summer", gradient: Gradient(colors: [Color.red.opacity(0.3), Color.orange.opacity(0.3)])),
         GradientTheme(name: "Winter Freshness", gradient: Gradient(colors: [Color.white.opacity(0.3), Color.blue.opacity(0.3)])),
         GradientTheme(name: "Misty Morning", gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.mint.opacity(0.3)]))
     ]
 }
 
 */


class GradientTheme: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    @Published var gradient: Gradient
    
    init(name: String, gradient: Gradient) {
        self.name = name
        self.gradient = gradient
    }
    
}

class GradientThemeManager: ObservableObject {
    @Published var themes: [GradientTheme] = [
        GradientTheme(name: "deepocean", gradient: Gradient(colors: [.blue, .black, .blue])),
        GradientTheme(name: "Sunset", gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.pink.opacity(0.3)])),
        GradientTheme(name: "Ocean", gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)])),
        GradientTheme(name: "Forest", gradient: Gradient(colors: [Color.green.opacity(0.3), Color.mint.opacity(0.3)])),
        GradientTheme(name: "Lilac Dawn", gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.indigo.opacity(0.3)])),
        GradientTheme(name: "Sandstorm", gradient: Gradient(colors: [Color.brown.opacity(0.3), Color.yellow.opacity(0.3)])),
        GradientTheme(name: "Northern Lights", gradient: Gradient(colors: [Color.cyan.opacity(0.3), Color.green.opacity(0.3)])),
        GradientTheme(name: "Storm Front", gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.blue.opacity(0.3)])),
        GradientTheme(name: "Hot Summer", gradient: Gradient(colors: [Color.red.opacity(0.3), Color.orange.opacity(0.3)])),
        GradientTheme(name: "Winter Freshness", gradient: Gradient(colors: [Color.white.opacity(0.3), Color.blue.opacity(0.3)])),
        GradientTheme(name: "Misty Morning", gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.mint.opacity(0.3)]))
    ]
}


class loadGradient {
  
    var contentsOfFile: String = ""
    var gradientThemesManager = GradientThemeManager()  // Create an instance of GradientThemeManager
    
    func getThecontents()  {
        let pathsManager = pathsManager()
        let path = pathsManager.createGradientFolderAndFileInside()
        self.contentsOfFile = pathsManager.readFilePlain(path)
    }
    
    func getRightgradient() -> Gradient {
        
        // Iterate through all available themes and return the matching gradient
        for theme in gradientThemesManager.themes {
            if theme.name == self.contentsOfFile {
                return theme.gradient
            }
        }
        
        // If no match is found, return a default gradient (e.g., black to white)
        return Gradient(colors: [.black, .white])
    }
}
