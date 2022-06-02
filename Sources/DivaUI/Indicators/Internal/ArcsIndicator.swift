//
//  Created by Carson Rau on 2/3/22.
//

import SwiftUI

internal struct ArcsIndicator: View {
    private let count: Int = 3
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                ArcsIndicatorItem(index: idx, count: self.count, size: proxy.size)
            }
        }
    }
}

fileprivate struct ArcsIndicatorItem: View {
    let index: Int
    let count: Int
    let size: CGSize
    @State private var rotation: Double = 0.0
    var body: some View {
        let animation = Animation.default
                .speed(Double.random(in: 0.2 ... 0.5))
                .repeatForever(autoreverses: false)
        return Group { () -> Path in
            var p = Path()
            p.addArc(
                    center: CGPoint(x: self.size.width / 2, y: self.size.height / 2),
                    radius: self.size.width / 2 - CGFloat(self.index) * CGFloat(self.count),
                    startAngle: .degrees(0),
                    endAngle: .degrees(Double(Int.random(in: 120 ... 300))),
                    clockwise: true
            )
            return p.strokedPath(.init(lineWidth: 2))
        }
                .frame(width: size.width, height: size.height)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    self.rotation = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        withAnimation(animation) {
                            self.rotation = 360.0
                        }
                    }
                }
    }
}
