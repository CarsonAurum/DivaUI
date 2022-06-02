//
//  Created by Carson Rau on 2/3/22.
//

import SwiftUI

internal struct RotatingDotsIndicator: View {
    private let count: Int = 5
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                RotatingDotsIndicatorItem(index: idx, size: proxy.size)
            }
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

fileprivate struct RotatingDotsIndicatorItem: View {
    let index: Int
    let size: CGSize
    @State private var scale: CGFloat = 0
    @State private var rotation: Double = 0
    var body: some View {
        let animation = Animation
                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                .repeatForever(autoreverses: false)
        return Circle()
                .frame(width: size.width / 5, height: size.height / 5)
                .scaleEffect(scale)
                .offset(y: size.width / 10 - size.height / 2)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    self.rotation = 0
                    self.scale = (5 - CGFloat(self.index)) / 5
                    withAnimation(animation) {
                        self.rotation = 360
                        self.scale = (1 + CGFloat(self.index)) / 5
                    }
                }
    }
}
