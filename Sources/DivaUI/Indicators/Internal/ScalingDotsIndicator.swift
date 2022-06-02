//
// Created by Carson Rau on 2/24/22.
//

import SwiftUI

internal struct ScalingDotsIndicator: View {
    private let count: Int =  3
    private let inset: Int = 2
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                ScalingDotsIndicatorItem(index: idx, count: count, inset: inset, size: proxy.size)
            }
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}


fileprivate struct ScalingDotsIndicatorItem: View {
    let index: Int
    let count: Int
    let inset: Int
    let size: CGSize
    @State private var scale: CGFloat = 0
    var body: some View {
        let itemSize = (size.width - CGFloat(inset) * CGFloat(count - 1)) / CGFloat(count)
        let animation = Animation.easeOut
                .repeatForever(autoreverses: true)
                .delay(Double(index) / Double(count) / 2)
        return Circle()
                .frame(width: itemSize, height: itemSize)
                .scaleEffect(scale)
                .onAppear {
                    self.scale = 1
                    withAnimation(animation) {
                        self.scale = 0.3
                    }
                }
                .offset(x: (itemSize + CGFloat(inset)) * CGFloat(index) - size.width / 2 * itemSize / 2)
    }
}
