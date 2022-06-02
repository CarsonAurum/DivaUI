//
//  Created by Carson Rau on 3/28/22.
//

import SwiftUI

public struct OrbitalCircleSpinner: View {
    @Binding public var animating: Bool
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .frame(width: 150, height: 150)
                .foregroundColor(.init(.systemGray))
            Circle()
                .trim(from: 0, to: 1/4)
                .stroke(style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 150, height: 150)
                .foregroundColor(.init(.systemYellow))
                .overlay(
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.init(.systemYellow))
                        .offset(x: 0, y: 75)
                )
                .shadow(color: .init(.systemYellow), radius: 5, x: 1, y: 1)
                .offset()
                .rotationEffect(.degrees(animating ? 360 : 0))
                .animation(.linear(duration: 2.5).repeatForever(autoreverses: false))
        }
        .onAppear {
            animating.toggle()
        }
    }
}

#if DEBUG
struct OrbitalCircleSpinnerContainer: View {
    @State private var animating: Bool = false
    var body: some View {
        OrbitalCircleSpinner(animating: $animating)
    }
}
struct OrbitalCircleSpinner_Preview: PreviewProvider {
    static var previews: some View {
        OrbitalCircleSpinnerContainer()
    }
}
#endif
