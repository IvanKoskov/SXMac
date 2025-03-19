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

// Thank you  @TS0NW0RK for all of the themes !!

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
        GradientTheme(name: "Misty Morning", gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.mint.opacity(0.3)])),
        GradientTheme(name: "Galaxy", gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5), Color.black.opacity(0.6)])),
        GradientTheme(name: "Aurora Borealis", gradient: Gradient(colors: [Color.green.opacity(0.5), Color.blue.opacity(0.3), Color.purple.opacity(0.4)])),
        GradientTheme(name: "Sunrise", gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.yellow.opacity(0.5), Color.pink.opacity(0.5)])),
        GradientTheme(name: "Cherry Blossom", gradient: Gradient(colors: [Color.pink.opacity(0.4), Color.white.opacity(0.4)])),
        GradientTheme(name: "Lavender Fields", gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.pink.opacity(0.5)])),
        GradientTheme(name: "Citrus Burst", gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.yellow.opacity(0.5)])),
        GradientTheme(name: "Deep Space", gradient: Gradient(colors: [Color.black.opacity(0.8), Color.blue.opacity(0.6), Color.purple.opacity(0.4)])),
        GradientTheme(name: "Tropical Paradise", gradient: Gradient(colors: [Color.teal.opacity(0.3), Color.green.opacity(0.3), Color.yellow.opacity(0.4)])),
        GradientTheme(name: "Cobalt Night", gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.5)])),
        GradientTheme(name: "Red Velvet", gradient: Gradient(colors: [Color.red.opacity(0.5), Color.pink.opacity(0.3)])),
        GradientTheme(name: "Peach Sorbet", gradient: Gradient(colors: [Color.pink.opacity(0.4), Color.orange.opacity(0.3), Color.yellow.opacity(0.3)])),
        GradientTheme(name: "Mint Breeze", gradient: Gradient(colors: [Color.mint.opacity(0.5), Color.cyan.opacity(0.3)])),
        GradientTheme(name: "Fireworks", gradient: Gradient(colors: [Color.red.opacity(0.6), Color.orange.opacity(0.4), Color.yellow.opacity(0.2)])),
        GradientTheme(name: "Icy Blue", gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.cyan.opacity(0.3)])),
        GradientTheme(name: "Pink Sunset", gradient: Gradient(colors: [Color.pink.opacity(0.4), Color.orange.opacity(0.4), Color.red.opacity(0.4)])),
        GradientTheme(name: "Golden Hour", gradient: Gradient(colors: [Color.yellow.opacity(0.7), Color.orange.opacity(0.5)])),
        GradientTheme(name: "Autumn Leaves", gradient: Gradient(colors: [Color.orange.opacity(0.5), Color.red.opacity(0.4), Color.brown.opacity(0.3)])),
        GradientTheme(name: "Midnight", gradient: Gradient(colors: [Color.black.opacity(0.9), Color.blue.opacity(0.5)])),
        GradientTheme(name: "Blush", gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.white.opacity(0.5)])),
        GradientTheme(name: "Tropical Sunset", gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.pink.opacity(0.5), Color.purple.opacity(0.4)])),
        GradientTheme(name: "Crystal Waters", gradient: Gradient(colors: [Color.cyan.opacity(0.6), Color.blue.opacity(0.5), Color.green.opacity(0.3)])),
        GradientTheme(name: "Firelight", gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.red.opacity(0.6), Color.yellow.opacity(0.5)])),
        GradientTheme(name: "Winter Wonderland", gradient: Gradient(colors: [Color.white.opacity(0.6), Color.blue.opacity(0.5), Color.cyan.opacity(0.3)])),
        GradientTheme(name: "Cotton Candy", gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.blue.opacity(0.4), Color.purple.opacity(0.3)])),
        GradientTheme(name: "Tidal Wave", gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.teal.opacity(0.3), Color.green.opacity(0.2)])),
        GradientTheme(name: "Sunlit Forest", gradient: Gradient(colors: [Color.green.opacity(0.5), Color.yellow.opacity(0.4), Color.brown.opacity(0.3)])),
        GradientTheme(name: "Nebula", gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.5), Color.black.opacity(0.7)])),
        GradientTheme(name: "Tangerine Sky", gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.pink.opacity(0.4)])),
        GradientTheme(name: "Deep Sea", gradient: Gradient(colors: [Color.teal.opacity(0.7), Color.blue.opacity(0.5)])),
        GradientTheme(name: "Soft Breeze", gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.green.opacity(0.3), Color.white.opacity(0.4)])),
        GradientTheme(name: "Berry Delight", gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.red.opacity(0.4), Color.pink.opacity(0.3)])),
        GradientTheme(name: "Tropical Lagoon", gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.green.opacity(0.4), Color.teal.opacity(0.3)])),
        GradientTheme(name: "Copper Dawn", gradient: Gradient(colors: [Color.brown.opacity(0.6), Color.orange.opacity(0.5)])),
        GradientTheme(name: "Electric Violet", gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.4)])),
        GradientTheme(name: "Lavender Haze", gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.blue.opacity(0.5)])),
        GradientTheme(name: "Pink Lemonade", gradient: Gradient(colors: [Color.pink.opacity(0.5), Color.yellow.opacity(0.3)])),
        GradientTheme(name: "Starry Night", gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.black.opacity(0.8)])),

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
