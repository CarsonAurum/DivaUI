//
//  Created by Carson Rau on 2/3/22.
//

import SwiftUI

internal struct DefaultIndicator: View {
    private let count: Int = 8
    public var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                DefaultIndicatorItem(index: idx, count: count, size: proxy.size)
            }
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

fileprivate struct DefaultIndicatorItem: View {
    let index: Int
    let count: Int
    let size: CGSize
    @State private var opacity: Double = 0.0
    var body: some View {
        let height = size.height / 3.2
        let width = height / 2
        let angle = 2 * .pi / CGFloat(count) * CGFloat(index)
        let x = (size.width / 2 - height / 2) * cos(angle)
        let y = (size.height / 2 - height / 2) * sin(angle)
        let animation = Animation.default
                .repeatForever(autoreverses: true)
                .delay(Double(index) / Double(count) / 2)
        return RoundedRectangle(cornerRadius: width / 2 + 1)
                .frame(width: width, height: height)
                .rotationEffect(Angle(radians: Double(angle + CGFloat.pi / 2)))
                .offset(x: x, y: y)
                .opacity(opacity)
                .onAppear {
                    self.opacity = 1.0
                    withAnimation(animation) {
                        self.opacity = 0.3
                    }
                }
    }
}
