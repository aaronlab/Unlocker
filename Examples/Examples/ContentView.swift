//
//  ContentView.swift
//  Examples
//
//  Created by Aaron Lee on 2021/02/07.
//

import SwiftUI
import Unlocker

struct ContentView: View {
    
    @State private var percentage: Float = 0.0
    
    var body: some View {
        Unlocker(percentage: $percentage, minPercentage: 0.0, threshold: 50.0) {
            // Action
        }
        .background(Color.gray)
        .frame(height: 60)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
