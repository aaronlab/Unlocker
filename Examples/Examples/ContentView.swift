//
//  ContentView.swift
//  Examples
//
//  Created by Aaron Lee on 2021/02/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
