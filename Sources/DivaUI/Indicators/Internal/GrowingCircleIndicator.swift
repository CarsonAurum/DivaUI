//
// Created by Carson Rau on 2/24/22.
//

import SwiftUI

internal struct GrowingCircleIndicator: View {
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    var body: some View {
        let animation = Animation.easeIn(duration: 1.1)
                .repeatForever(autoreverses: false)
        return Circle()
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    self.scale = 0
                    self.opacity = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        withAnimation(animation) {
                            self.scale = 1
                            self.opacity = 0
                        }
                    }
                }
    }
}
