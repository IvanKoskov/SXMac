//
//  AboutView.swift
//  SXMac
//
//  Created by Evan Matthew on 12/3/2568 BE.
//

import SwiftUI

struct AboutView: View {
    
    @State private var showDescription: Bool = false
    
    
    var body: some View {
        VStack {
           
            HStack {
                Text("SXMac")
                    .font(.title)
                    .padding()
                    .bold()
                
                Image(systemName: "eye")
                    .font(.system(size: 40))
            }
            
            
            
            
            
            Button("Version 2.0.0 alpha") {
                
                showDescription = true
                
            }
            .foregroundColor(.white)
                
                .bold()
                .popover(isPresented: $showDescription) {
                    
                    VStack {
                        
                        Text("```SXMac - on the go light rich text```")
                            .padding()
                        
                        Text("```editor, code editor, markdown editor```")
                    }
                    
                    .frame(width: 320, height: 220)
                }
          
            Link(destination: URL(string: "https://github.com/IvanKoskov/SXMac")!) {
                HStack {
                    Text("Versions")
                    Image("git")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
            }
            

        }
        .frame(width: 300, height: 200)
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.cyan, .blue, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }
      
        
}
