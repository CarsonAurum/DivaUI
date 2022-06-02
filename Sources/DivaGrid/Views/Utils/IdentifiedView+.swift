//
//  Created by Carson Rau on 8/1/21.
//

import SwiftUI
import DivaCore

internal extension View {
    func extractContentViews() -> [IdentifiedView] {
        if let container: GridForEachRangeInt = -?>self {
            return container.contentViews
        } else if let container: GridForEachIdentifiable = -?>self {
            return container.contentViews
        } else if let container: GridForEachID = -?>self {
            return container.contentViews
        } else if let container: GridGroupContaining = -?>self {
            return container.contentViews
        } else if let container: _ConstructedView = -?>self {
            return container.contentViews
        }
        return [.init(hash: nil, view: AnyView(self))]
    }
}

internal extension Array where Element == IdentifiedView {
    func asGridElements<T: Hashable>(index: inout Int, baseHash: T) -> [GridElement] {
        self
            .enumerated()
            .map {
                let gridHash: AnyHashable
                if let viewHash = $0.1.hash {
                    gridHash = viewHash
                } else {
                    gridHash = .init([baseHash, AnyHashable(index)])
                    index += 1
                }
                return .init($0.1.view, id: gridHash)
            }
    }
    
    func asGridElements(index: inout Int) -> [GridElement] {
        self
            .map {
                let gridHash: AnyHashable
                if let viewHash = $0.hash {
                    gridHash = viewHash
                } else {
                    gridHash = .init(index)
                    index += 1
                }
                return .init($0.view, id: gridHash)
                
            }
    }
}
