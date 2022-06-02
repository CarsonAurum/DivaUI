//
// Created by Carson Rau on 2/24/22.
//

import SwiftUI

internal struct OpacityDotsIndicator: View {
    private let count: Int = 3
    private let inset: Int = 4
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
            }
        }
    }
}

fileprivate struct OpactiyDotsIndicatorItem: View {
    let index: Int
    let count: Int
    let inset: Int
    let size: CGSize
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    var body: some View {
        let itemSize = (size.width - CGFloat(inset) * CGFloat(count  - 1)) / CGFloat(count)
        let animation = Animation.easeOut
                .repeatForever(autoreverses: true)
                .delay(index % 2 == 0 ? 0.2 : 0)
        return Circle()
                .frame(width: itemSize, height: itemSize)
                .scaleEffect(scale)
                .opacity(scale)
                .onAppear {
                    self.scale = 1
                    self.opacity = 1
                    withAnimation(animation) {
                        self.scale = 0.9
                        self.opacity = 0.3
                    }
                }
                .offset(x: (itemSize -  CGFloat(inset) * CGFloat(index) - size.width / 2 *  itemSize / 2))
    }
}
