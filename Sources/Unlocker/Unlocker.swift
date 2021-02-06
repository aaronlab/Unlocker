import SwiftUI

public struct Unlocker: View {
    
    // Percentage
    @Binding var percantage: Float
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
        self._percantage = percentage
        self.minPercentage = minPercentage
        self.threshold = threshold
        self.completion = completion
    }
    
    public var body: some View {
        GeometryReader { geo in
            
        } //: G
    }
    
}
