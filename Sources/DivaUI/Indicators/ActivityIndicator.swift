//
//  Created by Carson Rau on 2/3/22.
//

import SwiftUI

public struct ActivityIndicator: View {
    public enum IndicatorType {
        case `default`
        case arcs
        case rotatingDots
        case flickeringDots
        case scalingDots
        case opacityDots
        case equalizer
        case growingArc(Color = .red)
        case growingCircle
        case gradient([Color], CGLineCap = .butt)
    }
    @Binding var isVisible: Bool
    var type: IndicatorType
    public init(isVisible: Binding<Bool>, type: IndicatorType) {
        self._isVisible = isVisible
        self.type = type
    }
    public var body: some View {
        if isVisible {
            indicator
        } else {
            EmptyView()
        }
    }
    internal var indicator: some View {
        ZStack {
            switch type {
            case .default:
                DefaultIndicator()
            case.arcs:
                ArcsIndicator()
            case .rotatingDots:
                RotatingDotsIndicator()
            case .flickeringDots:
                FlickeringDotsIndicator()
            case .scalingDots:
                ScalingDotsIndicator()
            case .opacityDots:
                OpacityDotsIndicator()
            case .equalizer:
                EqualizerIndicator()
            case .growingArc(let color):
                GrowingArcIndicator(color: color)
            case .growingCircle:
                GrowingCircleIndicator()
            case .gradient(let colors, let lineCap):
                GradientIndicator(colors: colors, lineCap: lineCap)
            }
        }
    }
}

#if DEBUG
struct ActivityIndicatorContainer: View {
    @State private var visible: Bool = true
    var body: some View {
        ActivityIndicator(isVisible: $visible, type: .equalizer)
            .frame(width: 200, height: 200, alignment: .center)
    }
}

struct ActivityIndicator_Preview: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorContainer()
    }
}
#endif
