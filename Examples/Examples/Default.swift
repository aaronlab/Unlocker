//
//  Default.swift
//  Examples
//
//  Created by Aaron Lee on 2021/02/07.
//

import SwiftUI
import Unlocker

struct Default: View {
    
    @State private var disabled: Bool = false
    @State private var percentage: Float = 0.0
    
    var body: some View {
        
        Unlocker(disabled: $disabled, percentage: $percentage, minPercentage: 0.0, threshold: 50.0) {
            // Your task here
            print("Process Started")
            
            /*
             Since the slider will be "disabled" after fully swiped,
             you will need to toggle "disabled" parameter at the end of your process,
             so that you will be able to make the slider activated again.
             Or if you don't want to make it back,
             just leave it there.
             Or if you don't want to make it disabled ever,
             just use `.constant(false)`
             */
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("Process Done")
                disabled.toggle()
            }
            
        }
        .background(Color.gray)
        .frame(height: 60)
        .padding()
    }
}
