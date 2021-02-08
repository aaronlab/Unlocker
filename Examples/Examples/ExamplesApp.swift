//
//  ExamplesApp.swift
//  Examples
//
//  Created by Aaron Lee on 2021/02/07.
//

import SwiftUI

@main
struct ExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                
                Default()
                    .tabItem {
                        Text("Default")
                    }
                
                RoundedRect()
                    .tabItem {
                        Text("Rounded Rectangle")
                    }
                
                CapsuleShape()
                    .tabItem {
                        Text("Capsule")
                    }
                
            }
        }
    }
}
