//
// Created by Carson Rau on 3/18/22.
//

#if canImport(SwiftUI)
import SwiftUI

public struct Line: Shape {
    private let unitPoints: [UnitPoint]
    public init(unitPoints: [UnitPoint]) {
        self.unitPoints = unitPoints
    }
    init<Data: RandomAccessCollection>(unitData: Data) where Data.Element: BinaryFloatingPoint {
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        unitPoints = unitData.enumerated().map { .init(x: step * CGFloat($0.0), y: CGFloat($0.1)) }
    }
    public func path(in rect: CGRect) -> Path {
        Path { $0.addLines(unitPoints.points(in: rect)) }
    }
}

struct Line_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            Line(unitPoints: [
                .init(x: 0, y: 0),
                .init(x: 0.5, y: 0.3),
                .init(x: 1, y: 0.75)
            ])
                .stroke(.red, style: .init(lineWidth: 4, lineCap: .round))
                .drawingGroup()
                .previewLayout(.fixed(width: 400, height: 300))
            Line(unitData: [0.0, 0.3, 0.75])
                .stroke(.red, style: .init(lineWidth: 4, lineCap: .round))
                .drawingGroup()
                .previewLayout(.fixed(width: 400, height: 300))
        }
    }
}
#endif
