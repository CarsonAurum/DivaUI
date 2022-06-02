//
//  Created by Carson Rau on 7/31/21.
//

#if canImport(SwiftUI)
import SwiftUI

/// Collection of static defaults to be used within a Grid view when modifiers are not configured at instantiation.
public enum GridDefaults {
    /// The default number of columns that an element should span.
    ///
    /// Default value: `1`
    ///
    /// See ``GridSpan`` for more information.
    public static let columnSpan = 1
    /// The default number of rows that an element should span.
    ///
    /// Default value: `1`
    ///
    /// See ``GridSpan`` for more information.
    public static let rowSpan = 1
    /// The default number of points that should separate elements within the grid.
    ///
    /// Default value: `5` points.
    /// 
    /// See ``GridSpacing`` for more information.
    public static let spacing: GridSpacing = 5.0
    /// The default fractional component of free space to alot to each flexible track within a grid.
    ///
    /// Default value: `1`
    ///
    /// See ``GridTrack/fr(_:)`` for more information.
    public static let fractionSize: CGFloat = 1.0
    /// The default content mode.
    ///
    /// Default value: `.fill`
    ///
    /// See ``GridContentMode`` for more information.
    public static let contentMode: GridContentMode = .fill
    public static let flow: GridFlow = .rows
    /// The default packing method.
    ///
    /// Default value: `.sparse`
    ///
    /// See ``GridPacking`` for more information.
    public static let packing: GridPacking = .sparse
    public static let cacheMode: GridCacheMode = .inMemoryCache
    public static let commonItemsAlignment: GridAlignment = .center
    public static let contentAlignment: GridAlignment = .center
}
#endif
