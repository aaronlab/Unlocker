//
//  RoundedRect.swift
//  Examples
//
//  Created by Aaron Lee on 2021/02/08.
//

import SwiftUI
import Unlocker

struct RoundedRect: View {
    
    @State private var disabled: Bool = false
    @State private var percentage: Float = 0.0
    
    var body: some View {
        
        ZStack {
            
            Color.gray
            
            // Background
            HStack {
                Spacer(minLength: 0)
                Text("Slide to Unlock")
                Image(systemName: "chevron.right.2")
            } //: H
            .padding(.trailing)
            
            // Slider
            Unlocker(disabled: $disabled, percentage: $percentage, minPercentage: 25, threshold: 50.0) { sliderWidth in
                ZStack {
                    
                    // Slider Background
                    Rectangle()
                        .foregroundColor(.primary)
                    
                    /*
                     You can choose when you are going to show your content
                     with the escaping parameter(CGFloat), which is the slider's width.
                     */
                    if sliderWidth > UIScreen.main.bounds.width / 2.8 {
                        
                        // Slider Content
                        HStack {
                            
                            Text("Slide to Unlock")
                                .foregroundColor(.blue)
                                .lineLimit(1)
                                .padding(.leading)
                            
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.blue)
                            
                            Spacer(minLength: 0)
                            
                        } //: H
                        
                    } else {
                        
                        /*
                         Placeholder Image before slide
                         */
                        Image(systemName: "chevron.right.2")
                            .foregroundColor(.blue)
                        
                    }
                    
                }
            } completion: {
                // Your task here
                print("RoundedRect Process Started")
                
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
                    print("RoundedRect Process Done")
                    disabled.toggle()
                }
            }
            
            
        } //: Z
        .font(.system(size: 12))
        .frame(height: 60)
        /*
         You can smiply make the slider RoundedRectangle
         with `.clipShape(RoundedRectangle(cornerRadius: CGFloat))`
         */
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        
    }
    
}
