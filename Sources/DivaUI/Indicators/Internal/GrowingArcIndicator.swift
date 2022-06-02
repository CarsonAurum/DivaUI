//
//  Created by Carson Rau on 2/3/22.
//

import SwiftUI

internal struct GrowingArcIndicator: View {
    let color: Color
    @State private var animatable: Double = 0.0
    var body: some View {
        let animation = Animation
                .easeIn(duration: 2)
                .repeatForever(autoreverses: false)
        return GrowingArc(p: animatable)
                .stroke(color, lineWidth: 4)
                .onAppear {
                    self.animatable = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        withAnimation(animation) {
                            self.animatable = 1.0
                        }
                    }
                }
    }
}
fileprivate struct GrowingArc: Shape {
    var maxLength = 2 * Double.pi - 0.7
    var lag = 0.35
    var p: Double
    var animatableData: Double {
        get { return p }
        set { p = newValue }
    }
    func path(in rect: CGRect) -> Path {
        let h = p * 2
        var length = h * maxLength
        if h > 1 && h < lag + 1 {
            length = maxLength
        }
        if h > lag + 1 {
            let coeff = 1 / (1 - lag)
            let n = h - 1 - lag
            length = (1 - n * coeff) * maxLength
        }
        let first = Double.pi / 2
        let second = 4 * Double.pi - first
        var end = h * first
        if h > 1 {
            end = first + (h - 1) * second
        }
        let start = end + length
        var p = Path()
        p.addArc(
                center: CGPoint(x: rect.size.width / 2, y: rect.size.width / 2),
                radius: rect.size.width / 2,
                startAngle: .radians(start),
                endAngle: .radians(end),
                clockwise: true
        )
        return p
    }
}
