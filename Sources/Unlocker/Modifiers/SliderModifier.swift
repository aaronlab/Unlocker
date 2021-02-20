//
//  SliderModifier.swift
//  
//
//  Created by Aaron Lee on 2021/02/20.
//

import SwiftUI

/// Slider Width + Foreground Color Modifier
struct SliderModifier: ViewModifier {
    
    let width: CGFloat
    let foregroundColor: Color
    
    init(width: CGFloat, foregroundColor: Color) {
        self.width = width
        self.foregroundColor = foregroundColor
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .foregroundColor(foregroundColor)
    }
}
