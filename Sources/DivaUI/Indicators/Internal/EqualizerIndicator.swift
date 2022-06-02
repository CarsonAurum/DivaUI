//
// Created by Carson Rau on 2/24/22.
//

import SwiftUI

internal struct EqualizerIndicator: View {
    private let count: Int = 5
    var body: some View {
        GeometryReader { proxy in
            ForEach(0 ..< self.count) { idx in
                EqualizerIndicatorItem(index: idx, count: self.count, size: proxy.size)
            }
                    .frame(width: proxy.size.width, height: proxy.size.height)
        }
    }
}

fileprivate struct EqualizerIndicatorItem: View {
    let index: Int
    let count: Int
    let size: CGSize
    
    @State private var scale: CGFloat = 0
    
    var body: some View {
        let itemSize = size.width / CGFloat(count) / 2
        let animation = Animation.easeInOut.delay(0.2)
                .repeatForever(autoreverses: true)
                .delay(Double(index)  / Double(count) / 2)
        return RoundedRectangle(cornerRadius: 3)
                .frame(width: itemSize, height: size.height)
                .scaleEffect(x: 1, y: scale, anchor: .center)
                .onAppear {
                    self.scale = 1
                    withAnimation(animation)  {
                        self.scale = 0.4
                    }
                }
                .offset(x: 2 * itemSize * CGFloat(index) - size.width / 2 + itemSize / 2)
    }
}
