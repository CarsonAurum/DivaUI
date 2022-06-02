//
// Created by Carson Rau on 2/24/22.
//

import SwiftUI

internal struct FlickeringDotsIndicator: View {
    private let count: Int = 8
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                FlickeringDotsIndicatorItem(index: idx, count: self.count, size: proxy.size)
            }
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

fileprivate struct FlickeringDotsIndicatorItem: View {
    let index: Int
    let count: Int
    let size: CGSize
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    
    var body: some View {
        let duration = 0.5
        let itemSize = size.height / 5
        let angle  = 2  * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let x = (size.width / 2 - itemSize / 2) * cos(angle)
        let y = (size.width / 2 - itemSize / 2) * sin(angle)
        let animation = Animation.linear(duration: duration)
                .repeatForever(autoreverses: true)
                .delay(duration * Double(index) / Double(count) * 2)
        
        return Circle()
                .frame(width: itemSize, height: itemSize)
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    self.scale = 1
                    self.opacity = 1
                    withAnimation(animation) {
                        self.scale = 0.5
                        self.opacity = 0.3
                    }
                }
                .offset(x: x, y: y)
    }
}
