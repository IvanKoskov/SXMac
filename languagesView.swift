//
//  languagesView.swift
//  SXMac
//
//  Created by Evan Matthew on 11/03/2025
//


import SwiftUI
import CodeEditor //for code, custom views and etc








struct languagesView: View {
    
    @State private var languagesThemes = """
               For the most of those formats and themes you can edit text in SXMac:




1c, abnf, accesslog, actionscript, ada, angelscript, apache, applescript, arcade, arduino, armasm, asciidoc, aspectj, autohotkey, autoit, avrasm, awk, axapta, bash, basic, bnf, brainfuck, cal, capnproto, ceylon, clean, clojure, clojure-repl, cmake, coffeescript, coq, cos, cpp, crmsh, crystal, cs, csp, css, d, dart, delphi, diff, django, dns, dockerfile, dos, dsconfig, dts, dust, ebnf, elixir, elm, erb, erlang, erlang-repl, excel, fix, flix, fortran, fsharp, gams, gauss, gcode, gherkin, glsl, gml, go, golo, gradle, groovy, haml, handlebars, haskell, haxe, hsp, htmlbars, http, hy, inform7, ini, irpf90, isbl, java, javascript, jboss-cli, json, julia, julia-repl, kotlin, lasso, ldif, leaf, less, lisp, livecodeserver, livescript, llvm, lsl, lua, makefile, markdown, mathematica, matlab, maxima, mel, mercury, mipsasm, mizar, mojolicious, monkey, moonscript, n1ql, nginx, nimrod, nix, nsis, objectivec, ocaml, openscad, oxygene, parser3, perl, pf, pgsql, php, plaintext, pony, powershell, processing, profile, prolog, properties, protobuf, puppet, purebasic, python, q, qml, r, reasonml, rib, roboconf, routeros, rsl, ruby, ruleslanguage, rust, sas, scala, scheme, scilab, scss, shell, smali, smalltalk, sml, sqf, sql, stan, stata, step21, stylus, subunit, swift, taggerscript, tap, tcl, tex, thrift, tp, twig, typescript, vala, vbnet, vbscript, vbscript-html, verilog, vhdl, vim, x86asm, xl, xml, xquery, yaml, zephir]
[a11y-dark, a11y-light, agate, an-old-hope, androidstudio, arduino-light, arta, ascetic, atelier-cave-dark, atelier-cave-light, atelier-dune-dark, atelier-dune-light, atelier-estuary-dark, atelier-estuary-light, atelier-forest-dark, atelier-forest-light, atelier-heath-dark, atelier-heath-light, atelier-lakeside-dark, atelier-lakeside-light, atelier-plateau-dark, atelier-plateau-light, atelier-savanna-dark, atelier-savanna-light, atelier-seaside-dark, atelier-seaside-light, atelier-sulphurpool-dark, atelier-sulphurpool-light, atom-one-dark, atom-one-dark-reasonable, atom-one-light, brown-paper, codepen-embed, color-brewer, darcula, dark, darkula, default, docco, dracula, far, foundation, github, github-gist, gml, googlecode, grayscale, gruvbox-dark, gruvbox-light, hopscotch, hybrid, idea, ir-black, isbl-editor-dark, isbl-editor-light, kimbie.dark, kimbie.light, lightfair, magula, mono-blue, monokai, monokai-sublime, nord, obsidian, ocean, paraiso-dark, paraiso-light, pojoaque, purebasic, qtcreator_dark, qtcreator_light, railscasts, rainbow, routeros, school-book, shades-of-purple, solarized-dark, solarized-light, sunburst, tomorrow, tomorrow-night, tomorrow-night-blue, tomorrow-night-bright, tomorrow-night-eighties, vs, vs2015, xcode, xcode-dark, xt256, zenburn
"""
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    // Rounded background without color
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.gray, lineWidth: 1) // Optional: Adds a border around the rounded rectangle
                        .background(Color.white.opacity(0.1)) // Optional: Adds a slight background color
                        .cornerRadius(15)
                    
                    // TextEditor
                    TextEditor(text: $languagesThemes)
                        .padding()
                        .foregroundColor(Color.gray)
                        .font(.custom("HelveticaNeue", size: 13))
                        .disabled(true)
                }
             
                
                Link(destination: URL(string: "https://github.com/ZeeZide")!) {
                    Text("Thanks ZeeZide's Swift library")
                }
                    .padding()
                    .font(.system(size: 13))
                    .italic()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .padding()
            .toolbar {
                // Set the window title for macOS
                ToolbarItem(placement: .principal) {
                    Text("Settings languages info")
                        .font(.headline)
                    
                }
            }
        }
        
        
    }
    
}
