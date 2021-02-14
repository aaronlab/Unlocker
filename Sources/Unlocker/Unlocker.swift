import SwiftUI

public struct Unlocker: View {
    
    // Disable
    @Binding var disabled: Bool
    // Percentage
    @Binding var percentage: Float
    private let minPercentage: Float
    private let threshold: Float
    
    // Color
    private let foregroundColor: Color
    
    // Action
    private let completion: (() -> Void)?
    
    public init(
        disabled: Binding<Bool>,
        percentage: Binding<Float>,
        minPercentage: Float = 25.0,
        threshold: Float = 50.0,
        foregroundColor: Color = .primary,
        completion: (() -> Void)? = nil
    ) {
        self._disabled = disabled
        self._percentage = percentage
        self.minPercentage = minPercentage
        self.threshold = threshold
        self.foregroundColor = foregroundColor
        self.completion = completion
    }
    
    public var body: some View {
        GeometryReader { geo in
            
            // Slider
            ZStack(alignment: .leading) {
                
                // Rectangle Slider
                Rectangle()
                    .frame(width: abs(geo.size.width * CGFloat(percentage / 100)))
                    .foregroundColor(foregroundColor)
            } //: Z
            .contentShape(Path(CGRect(origin: .zero, size: geo.size)))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        onChanged(with: value, geoProxy: geo)
                    })
                    .onEnded({ _ in
                        onEnded()
                    })
            )
        } //: G
        .disabled(disabled)
        .onAppear {
            percentage = minPercentage
        }
    }
    
}

// MARK: - Slider Gestures

extension Unlocker {
    
    // Slider OnChange
    private func onChanged(with value: DragGesture.Value, geoProxy: GeometryProxy) {
        
        // Dragged to the right
        if value.translation.width > 0 {
            if percentage >= minPercentage {
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        // change percentage value
                        percentage = min(max(minPercentage, Float(value.location.x / geoProxy.size.width * 100)), 100)
                    }
                }
            } else {
                // Less than min
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        // reset
                        percentage = minPercentage
                    }
                }
            }
        }
        
        // Dragged to the left / shouldn't change
        if value.translation.width < 0 {
            DispatchQueue.main.async {
                withAnimation(.easeOut) {
                    // reset
                    percentage = minPercentage
                }
            }
        }
    }
    
    // After released
    private func onEnded() {
        if percentage > threshold {
            
            disabled = true // prevent user interaction for the completion
            
            // Fill the slider
            DispatchQueue.main.async {
                withAnimation(.easeOut(duration: 0.3)) {
                    percentage = 100
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                completion?()
            }
            
            // Reset slider
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.3)) {
                    percentage = minPercentage
                }
            }
            
//            // Reset disabled
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                disabled = false
//            }
        } else {
            
            // Reset slider
            DispatchQueue.main.async {
                withAnimation(.easeOut) {
                    percentage = minPercentage
                }
            }
            
        }
    }
    
}

// MARK: - Slider Styles

extension Unlocker {
    
    /// Slider Styles
    public enum SliderStyle {
        case `default`, leftText, rightText, customView
    }
    
    /// Slider Styles
    public func sliderStyle(_ style: SliderStyle) -> some View {
        return self.body
    }
    
}
