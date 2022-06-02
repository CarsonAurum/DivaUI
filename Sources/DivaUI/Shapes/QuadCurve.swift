//
// Created by Carson Rau on 3/18/22.
//

#if canImport(SwiftUI)
import SwiftUI

public struct QuadCurve: Shape {
    let unitPoints: [UnitPoint]
    public init(unitPoints: [UnitPoint]) {
        self.unitPoints = unitPoints
    }
    public init <Data: RandomAccessCollection>(unitData: Data) where Data.Element: BinaryFloatingPoint {
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        unitPoints = unitData.enumerated().map { .init(x: step * CGFloat($0.0), y: CGFloat($0.1)) }
    }
    public func path(in rect: CGRect) -> Path {
        Path { $0.addQuadCurves(unitPoints.points(in: rect)) }
    }
}

struct QuadCurve_Preview: PreviewProvider {
    static var previews: some View {
        Group {
        QuadCurve(unitPoints:
                    [
                        .init(x: 0.0, y: 0.25),
                        .init(x: 0.4, y: 0.50),
                        .init(x: 0.6, y: 0.75),
                        .init(x: 1, y: 0.25)
                    ]
        )
                .stroke(.red, style: .init(lineWidth: 4, lineCap: .round))
                .drawingGroup()
                .previewLayout(.fixed(width: 400, height: 300))
        
            QuadCurve(unitData: [0.25, 0.5, 0.75, 0.25])
            .stroke(.red, style: .init(lineWidth: 4, lineCap: .round))
            .drawingGroup()
            .previewLayout(.fixed(width: 400, height: 300))
        }
    }
}
#endif
