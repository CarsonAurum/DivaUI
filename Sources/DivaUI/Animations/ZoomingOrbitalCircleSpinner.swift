//
//  Created by Carson Rau on 3/28/22.
//

import SwiftUI

public struct ZoomingOrbitalCircleSpinner: View {
    @Binding public var animate: Bool
    public var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.init(red: 0, green: 0.5, blue: 1))
                .scaleEffect(animate ? 1 : 0.5)
                .animation(
                    .interpolatingSpring(stiffness: 170, damping: 20)
                        .speed(1.5)
                        .repeatForever(autoreverses: true)
                )
            ZStack {
                Circle()
                    .trim(from: 3/4, to: 1)
                    .stroke(style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .frame(width: 100, height: 100)
                    .foregroundColor(.init(red: 0, green: 0.5, blue: 1))
                Circle()
                    .trim(from: 3/4, to: 1)
                    .stroke(style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
                    .frame(width: 100, height: 100)
                    .foregroundColor(.init(red: 0, green: 0.5, blue: 1))
                    .rotationEffect(.degrees(-180))
            }
            .scaleEffect(animate ? 1 : 0.4)
            .rotationEffect(.degrees(animate ? 360 : 0))
            .animation(
                .interpolatingSpring(stiffness: 170, damping: 20)
                    .speed(1.5)
                    .repeatForever(autoreverses: true)
            )
        }
        .onAppear {
            animate.toggle()
        }
    }
}

#if DEBUG
struct ZoomingOrbitalSpinnerContainer: View {
    @State private var animating: Bool = false
    var body: some View {
        ZoomingOrbitalCircleSpinner(animate: $animating)
    }
}
struct ZoomingOrbitalCircleSpinner_Preview: PreviewProvider {
    static var previews: some View {
        ZoomingOrbitalSpinnerContainer()
    }
}
#endif
