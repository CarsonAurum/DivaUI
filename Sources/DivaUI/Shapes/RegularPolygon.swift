//
//  Created by Carson Rau on 3/18/22.
//

import SwiftUI

public struct RegularPolygon: Shape, InsettableShape {
    let sides: UInt
    private let inset: CGFloat
    public func path(in rect: CGRect) -> Path {
        Path.regularPolygon(sides: sides, in: rect, inset: inset)
    }
    public func inset(by amount: CGFloat) -> some InsettableShape {
        RegularPolygon(sides: self.sides, inset: self.inset + amount)
    }
    public init(sides: UInt, inset: CGFloat = 0) {
        self.sides = sides
        self.inset = inset
    }
}

extension Path {
    fileprivate static func regularPolygon(sides: UInt, in rect: CGRect, inset: CGFloat = 0) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let center = CGPoint(x: width / 2.0, y: height / 2.0)
        return Path { path in
            (0...sides).forEach { idx in
                let angle = ((Double(idx) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                let point = CGPoint(
                    x: center.x + CGFloat(cos(angle) * hypotenuse),
                    y: center.y + CGFloat(sin(angle) * hypotenuse)
                )
                if idx == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}

struct RegularPolygon_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            RegularPolygon(sides: 3)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.blue)
            RegularPolygon(sides: 6)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.red)
            RegularPolygon(sides: 15)
                .strokeBorder(lineWidth: 20)
                .foregroundColor(.purple)
        }
    }
}
