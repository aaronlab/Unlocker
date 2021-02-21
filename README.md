[![Language: Swift 5](https://img.shields.io/badge/language-Swift5-orange?style=flat&logo=swift)](https://developer.apple.com/swift)
![Platform: iOS 13+](https://img.shields.io/badge/platform-iOS%2013%2B-blue?style=flat&logo=apple)
![SwiftPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen?style=flat&logo=swift)
[![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey?style=flat)](https://github.com/aaronLab/SweetCardScanner/blob/main/LICENSE)
[![Release version](https://img.shields.io/badge/release-v1.0.0.beta.2-blue)](https://github.com/aaronLab/SweetCardScanner/releases)

# Unlocker

Unlocker is a simple slider library for [SwiftUI](https://developer.apple.com/xcode/swiftui/), which can look like `Slide to Unlock`.

You can use this library easily wherever you want, such as `Slide to Purchase` for the payment UX.

<center>
<img src="./Docs/preview1.gif" width="260">
&nbsp;
&nbsp;
<img src="./Docs/preview2.gif" width="260">
&nbsp;
&nbsp;
<img src="./Docs/preview3.gif" width="260">
</center>

## Requirements

- iOS 13.0 + (due to SwiftUI)

## Installation

- In Xcode, add the URL of this repository in SwiftPM:

```http
https://github.com/aaronLab/Unlocker
```

## Usage

- Import `Unlocker` on top of the file.
- Put `Unlocker` with its parameters in the parenthesis.
- Declare:
  ```Swift
  Unlocker<Content>: View where Content: View(
      disabled: Binding<Bool>,
      percentage: Binding<Float>,
      minPercentage: Float = 25.0,
      threshold: Float = 50.0,
      duration: Double = 0.3,
      @ViewBuilder content: @escaping (_ sliderWidth: CGFloat) -> Content,
      completion: (() -> Void)? = nil
  )
  ```

## Parameter

- `disabled: Binding<Bool>`:

  - This is a flag to `prevent the slider works multiple times` during the process.
  - Since the slider will be "disabled" after fully swiped, `you will need to toggle "disabled"` parameter at the end of your process to make the slider activated again.
  - Or if you don't want to make it back, just leave it there.
  - Or if you don't want to make it disabled ever, just use `.constant(false)`

- `percentage: Binding<Float>`:

  - This is the percentage of the slider.
  - 1.0 is 1 percent.

- `minPercentage: Float = 25.0`:

  - The default value is `25.0`
  - This is `the minimum percentage`. When you set this not zero, the slider would be filled the percentage that you set.
  - This is a kind of `placeholders` for the slider.
  - You can make it a bit filled by using this parameter.
  - 25.0 means 25% of the slider will be filled.

- `threshold: Float = 50.0`:

  - The default value is `50.0`
  - This is the `threshold` where `the completion would start`. 
  - Also this will make your `slider disabled` to `prevent the slider works multiple times during the process`.
  - When the user swipe the slider more than the percentage of this value in the screen, the action closure will be triggered.
  
- `duration: Double = 0.3`:

  - The default value is `0.3`
  - This is the duration for the `animation` to make `the slider fully filled`.

- `content: (CGFloat) -> Content`:

  - This is the custom view inside of the slider, which escapes with the width of the slider drag gesture.

- `completion: (() -> Void)? = nil`:

  - The default value is `nil`
  - This `closure action` will be triggered by the slider.
  - The action which `will be run` the percentage of the progress of the slider has passed the threshold like a completion.

## Example

```Swift
import SwiftUI
import Unlocker

struct CapsuleShape: View {
    
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
                    if sliderWidth > UIScreen.main.bounds.width / 3.0 {
                        
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
                print("CapsuleShape Process Started")
                
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
                    print("CapsuleShape Process Done")
                    disabled.toggle()
                }
            }
            
            
        } //: Z
        .font(.system(size: 12))
        .frame(height: 60)
        /*
         You can smiply make the slider RoundedRectangle
         with `.clipShape(Capsule())`
         */
        .clipShape(Capsule())
        .padding()
        
    }
    
}
```

## More Examples

- See more examples [here](https://github.com/aaronLab/Unlocker/tree/master/Examples/Examples)

## License

Licensed under [MIT](https://github.com/aaronLab/Unlocker/blob/master/LICENSE) license.
