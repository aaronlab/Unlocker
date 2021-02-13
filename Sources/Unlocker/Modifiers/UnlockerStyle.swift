//
//  UnlockerStyle.swift
//  
//
//  Created by Aaron Lee on 2021/02/13.
//

import SwiftUI

public struct UnlockerStyle {
    
    /// Default Empty Slider Style
    public struct Default: ViewModifier {
        public func body(content: Content) -> some View {
            content
        }
    }
    
    /// Left Text Slider Style
    public struct LeftText: ViewModifier {
        public func body(content: Content) -> some View {
            content
        }
    }
    
    /// Right Text Slider Style
    public struct RightText: ViewModifier {
        public func body(content: Content) -> some View {
            content
        }
    }
    
    /// Custome View Slider Style
    public struct CustomView: ViewModifier {
        public func body(content: Content) -> some View {
            content
        }
    }
    
}
