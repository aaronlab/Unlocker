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
                
                Rectangle()
                    .frame(width: abs(geo.size.width * CGFloat(minPercentage / 100)))
            } //: Z
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        onChanged(with: value, geoProxy: geo)
                    })
                    .onEnded({ value in
                        
                    })
            )
        } //: G
    }
    
}

extension Unlocker {
    
    // 슬라이더 변경 감지 처리
    private func onChanged(with value: DragGesture.Value, geoProxy: GeometryProxy) {
        
        if value.translation.width > 0 && shouldChange {
            
            if percentage >= 25.0 {
                
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        percentage = min(max(minPercentage, Float(value.location.x / geoProxy.size.width * 100)), 100)
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    withAnimation(.easeOut) {
                        percentage = 25.0
                    }
                }
            }
        }
        
        if value.translation.width < 0 || !shouldChange {
            
            DispatchQueue.main.async {
                withAnimation(.easeOut) {
                    percentage = 25.0
                }
            }
            
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Unlocker(percentage: .constant(0.0))
                .frame(height: 60)
                .padding()
        }
    }
}
#endif
