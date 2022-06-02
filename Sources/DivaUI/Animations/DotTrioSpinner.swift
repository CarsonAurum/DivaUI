//
//  Created by Carson Rau on 3/29/22.
//

import SwiftUI

public struct DotTrioSpinner: View {
    @Binding var animating: Bool
    public var automatic: Bool = true
    public var duration: Double = 1
    public var topColor: Color = .init(red: 96/255, green: 174/255, blue: 201/255)
    public var leftColor: Color = .init(red: 244/255, green: 132/255, blue: 177/255)
    public var rightColor: Color = .init(red: 137/255, green: 192/255, blue: 188/255)
    
    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .fill(topColor)
                    .frame(height: proxy.size.height / 3)
                    .offset(x: 0, y: animating ? -proxy.size.height / 3 : 0)
                Circle()
                    .fill(leftColor)
                    .frame(height: proxy.size.height / 3)
                    .offset(x: animating ? -proxy.size.height / 3 : 0 , y: animating ? proxy.size.height / 3 : 0)
                Circle()
                    .fill(rightColor)
                    .frame(height: proxy.size.height / 3)
                    .offset(x: animating ? proxy.size.height / 3 : 0 , y: animating ? proxy.size.height / 3 : 0)
            }
            .animation(.easeInOut(duration: duration).repeatForever(autoreverses: true))
            .rotationEffect(.degrees(animating ? 360 : 0))
            .animation(.easeInOut(duration: duration).repeatForever(autoreverses: false))
        }
        .onAppear {
            if automatic { animating.toggle() }
        }
    }
}

#if DEBUG
struct DotTrioSpinnerContainer: View {
    @State private var animating: Bool = false
    var body: some View {
        DotTrioSpinner(animating: $animating)
            .frame(width: 80, height: 80, alignment: .center)
    }
}


struct DotTrioSpinner_Preview: PreviewProvider {
    static var previews: some View {
        DotTrioSpinnerContainer()
    }
}
#endif
