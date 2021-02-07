import SwiftUI

public struct Unlocker: View {
    
    // Percentage
    @Binding var percentage: Float
    private let minPercentage: Float
    private let threshold: Float
    
    // Action
    private let completion: (() -> Void)?
    
    // State
    @State private var shouldChange: Bool = true
    
    public init(
        percentage: Binding<Float>,
        minPercentage: Float = 25.0,
        threshold: Float = 50.0,
        completion: (() -> Void)? = nil
    ) {
        self._percentage = percentage
        self.minPercentage = minPercentage
        self.threshold = threshold
        self.completion = completion
    }
    
    public var body: some View {
        GeometryReader { geo in
            
            // Slider
            ZStack(alignment: .leading) {
                
                // Rectangle Slider
                Rectangle()
                    .frame(width: abs(geo.size.width * CGFloat(percentage / 100)))
            } //: Z
            .contentShape(Path(CGRect(origin: .zero, size: geo.size)))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        onChanged(with: value, geoProxy: geo)
                    })
                    .onEnded({ value in
                        
                    })
            )
        } //: G
        .onAppear {
            percentage = minPercentage
        }
    }
    
}

extension Unlocker {
    
    // Slider OnChange
    private func onChanged(with value: DragGesture.Value, geoProxy: GeometryProxy) {
        
        // Dragged to the right
        if value.translation.width > 0 && shouldChange {
            if percentage >= minPercentage {
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        // change percentage value
                        self.percentage = min(max(self.minPercentage, Float(value.location.x / geoProxy.size.width * 100)), 100)
                    }
                }
            } else {
                // Less than min
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        // reset
                        self.percentage = self.minPercentage
                    }
                }
            }
        }
        
        // Dragged to the left / shouldn't change
        if value.translation.width < 0 || !shouldChange {
            DispatchQueue.main.async {
                withAnimation(.easeOut) {
                    // reset
                    self.percentage = self.minPercentage
                }
            }
        }
    }
    
}
