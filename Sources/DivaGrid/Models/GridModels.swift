//
// Created by Carson Rau on 8/2/21.
//

#if canImport(SwiftUI)
import SwiftUI
import DivaCore

// MARK: - Public
public enum GridCacheMode {
    case inMemoryCache
    case noCache
}
/// Alignment type for items within a grid.
public typealias GridAlignment = Alignment
/// A type determining the way a grid displays its content within its partent view.
///
/// Grid content mode could be specified in the grid constructor, as well as using the `.gridContentMode(_:)`
/// view modifier. The constructor setting will receive priority over the view modifier.
///
/// This setting directly impacts the kinds of elements that can be effectively displayed. See ``scroll`` for more information.
public enum GridContentMode {
    /// Grid content can scroll in the growing direction.
    ///
    /// Grid tracks that are perpendicular to the grid flow direction (growing) will have a size of ``GridTrack/fit``.
    /// Due to the nature of scrollable content, in the growing direction all elements must have their sizes defined.
    case scroll
    /// Grid content mode will be scaled to fill the parent view.
    ///
    /// The grid will fill the entire space with the content. Grid tracks in the growing direction
    /// (perpendicular to the grid flow direction) are implicitly assumed to have a size of `.fr(1)`.
    /// See ``GridTrack/fr(_:)`` for more information about the implications of this track size.
    ///
    /// This is the default mode that is provided by ``GridDefaults/contentMode``
    case fill
}
/// An individual logical item placed in the grid.
public struct GridElement: Identifiable, Equatable, Hashable {
    /// Each grid element is uniquely identifiable by its `id`.
    public let id: AnyHashable
    /// The content of the grid element.
    public let view: AnyView
    let debugID = UUID()
    /// Create a new element with existing content.
    /// - Parameters:
    ///   - view: The conbtent associated with this element.
    ///   - id: The id associated with this element.
    public init<T: View>(_ view: T, id: AnyHashable) {
        self.view = AnyView(view)
        self.id = id
    }
    /// Determine if two grid elements are equal by identifier.
    /// - Parameters:
    ///   - lhs: The first element to compare.
    ///   - rhs: The second element to compare.
    /// - Returns: `true` if the elements are equal, `false` otherwise.
    public static func == (lhs: GridElement,
                           rhs: GridElement) -> Bool {
        lhs.id == rhs.id
    }
    /// Hash this element's identifier into a given hasher.
    /// - Parameter hasher: The hasher to combine add this element's identifier with.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
/// A type specifying the growing direction of the grid.
///
/// A grid has two kinds of tracks. The first kind of track relies on  predefined track sizes, this is
/// known as the fixed track. The number and size of fixed tracks is known. The tracks orthogonal
/// (perpendicular) to the fixed trak are the growing tracks. Content will grow in this direction.
public enum GridFlow: Equatable {
    /// The number of rows will grow as content is added to the grid.
    ///
    /// The number of columns is fixed and defined with track sizes. Grid items are placed moving between
    /// columns and switching to the next row after the last column.
    ///
    /// This is default flow type provided by ``GridDefaults/flow``
    case rows
    /// The number of columns will grow as content is added to the grid.
    ///
    /// The number of rows is fixed and defined with track sizes. Grid items are placed moving
    /// between rows and switching to the next column after the last row.
    case columns
}
/// A type specifying the method the auto-placing algorithm should use when populating the grid.
///
/// Grid packing can be specified in the grid constructor, as well as using the `.gridPacking(_:)`
/// view modifier. The constructor setting will receive priority over the view modifier.
public enum GridPacking {
    /// The placement algorithm will attempt to place smaller elements in previous index positions
    /// that would otherwise have been left as holes by the ``sparse`` packing method.
    ///
    /// This may cause some items to appear out of order when doing so would fill in holes left by
    /// larger items.
    case dense
    /// The placement algorithm will only move positively ("forward") in the growing direction.
    ///
    /// Because placement will never fill holes left by veritable size elements, the grid might be left
    /// with holes in the layout. This placement method ensures that the items within the grid appear
    /// in order.
    ///
    /// This is the default packing method provided by ``GridDefaults/packing``
    case sparse
}

/// A type representing the spacing between elements within the grid.
public struct GridSpacing: Hashable, ExpressibleByNumericLiteral, ExpressibleByArrayLiteral, ExpressibleByNilLiteral {
    /// The horizontal spacing between items within the grid.
    public let horizontal: CGFloat
    /// The vertical spacing between items within the grid.
    public let vertical: CGFloat
    /// No spaces in the grid.
    public static let zero = GridSpacing(horizontal: 0, vertical: 0)
    /// Instantiate a new value of this type with `horizontal` and `vertical` values.
    ///
    /// - Parameters:
    ///   - horizontal: The horizontal spacing value.
    ///   - vertical: The vertical spacing value.
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    /// Instantiate a new value of this type with the same `horizontal` and `vertical` values defined
    /// by a `Double` value.
    ///
    /// - Parameter value: The raw value to be used as both `horizontal` and `vertical` spacing.
    public init(floatLiteral value: Double) {
        self = Self.init(horizontal: CGFloat(value), vertical: CGFloat(value))
    }
    /// Instantiate a new value of this type with the same `horizontal` and `vertical` values defined
    /// by an `Int` value.
    ///
    /// - Parameter value: The raw value to be used as both `horizontal` and `vertical` spacing.
    public init(integerLiteral value: Int) {
        self = Self.init(horizontal: CGFloat(value), vertical: CGFloat(value))
    }
    /// Instantiate a new value of this type with an array literal.
    ///
    /// If the array given contains a single element, the `horizontal` and `vertical` spacing will
    /// be identical; however, if two elements are present, the first element will be used as `horizontal`
    /// spacing and the second element will be used as `vertical` spacing.
    ///
    /// - Parameter elements: The raw value array to be used to define this value.
    public init(arrayLiteral elements: CGFloat...) {
        assert(elements.count <= 2)
        var vertical: CGFloat = 0
        var horizontal: CGFloat = 0
        
        if elements.count > 1 {
            horizontal = elements[0]
            vertical = elements[1]
        } else if elements.count == 1 {
            vertical = elements[0]
            horizontal = elements[0]
        }
        self = Self.init(horizontal: horizontal, vertical: vertical)
    }
    /// Instantiate a new value of this type with nil (interpreted as `zero`).
    ///
    /// - Parameter nilLiteral: A void value.
    public init(nilLiteral: ()) {
        self = .zero
    }
}
/// A type representing the number of tracks a given element spans within the grid.
///
/// - Note: When a view with a span >= 2 that spans across the tracks with flexible size doesn't take
/// part in the sizing calculation for these tracks. This view will fit to the spanned tracks. So,
/// it's possible to place a view with unlimited size that spans tracks with content-based sizes
/// (``GridTrack/fit``).
///
/// - Note: The span for a particular item can be set using the `.gridSpan(column:row:)` view modifier.
public struct GridSpan: Equatable, Hashable, ExpressibleByArrayLiteral {
    /// The number of column tracks spanned by this item.
    public var column: Int
    /// The number of row tracks spanned by this item.
    public var row: Int
    /// The default span using the provided values.
    public static let `default` = GridSpan(column: GridDefaults.columnSpan, row: GridDefaults.rowSpan)
    /// Create a new span value.
    /// - Parameters:
    ///   - column: The number of column tracks to span.
    ///   - row: The number of row tracks to span.
    public init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    /// Create a new span value from an array.
    /// - Parameter elements: An array of two values to be interpreted as (column, row).
    public init(arrayLiteral elements: Int...) {
        assert(elements.count == 2)
        self = .init(column: elements[0], row: elements[1])
    }
}
/// The explicit start position of a particular grid element.
///
/// For every view, you are able to set explicit start position by specifying a column, row, or both.
/// The view will be positioned automatically if there is no start position specified. Firstly, views
/// with both column and row start positions are placed. Secondly, the auto-placing algorithm tries
/// to place view with either a column or row start position. If there are any conflicts, such views
/// are placed automatically and you see warning in the console. And at the very end views with no
/// explicit start position are placed.
///
/// Start position is defined using `.gridStart(column:row:)` modifier.
public struct GridStart: Equatable, Hashable, ExpressibleByArrayLiteral, ExpressibleByNilLiteral {
    /// The column start position of this element.
    public var column: Int?
    /// The row start position of this element.
    public var row: Int?
    /// The default start position for an element - no defined column or row.
    public static let `default` = GridStart(column: nil, row: nil)
    /// Instantiate a new start element using column, row, both, or neither.
    ///
    /// - Parameters:
    ///   - column: The column number to start this element.
    ///   - row: The row number to start this element.
    public init(column: Int? = nil, row: Int? = nil) {
        self.column = column
        self.row = row
    }
    /// Instantiate a new start element using an array literal.
    ///
    /// - Parameter elements: An array containing two elements to be interpreted as [column, row].
    public init(arrayLiteral elements: Int?...) {
        assert(elements.count == 2)
        self = GridStart(column: elements[0], row: elements[1])
    }
    /// Instantiate a new start element using a nil literal.
    ///
    /// This will return the ``GridStart/default`` value.
    ///
    /// - Parameter nilLiteral: A void value.
    public init(nilLiteral: ()) {
        self = .default
    }
}
/// Size of the each track.
/// fr(N) sizes a track proportionally to the bounding rect with the respect of specified fraction N as a part of total fractions count.
/// const(N) sizes a track to be equal to the specified size N.
public enum GridTrack: Equatable, Hashable {
    case fr(CGFloat)
    case pt(CGFloat)
    case fit
}

extension Array: ExpressibleByIntegerLiteral where Element == GridTrack {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: Self.IntegerLiteralType) {
        self = .init(repeating: .fr(GridDefaults.fractionSize), count: value)
    }
}

// MARK: - Internal
/// The abstract position of a grid item within a grid view.
@usableFromInline
internal struct ArrangedItem: Equatable, Hashable {
    let gridElement: GridElement
    let startIndex: GridIndex
    let endIndex: GridIndex
    /// The height of this item in grid units.
    @usableFromInline
    var columnsCount: Int { endIndex.column - startIndex.column + 1 }
    /// The width of this item in grid units.
    @usableFromInline
    var rowsCount: Int { endIndex.row - startIndex.row + 1 }
    var area: Int { rowsCount * columnsCount }
    var span: GridSpan { .init(column: columnsCount, row: rowsCount) }
    func contains(_ index: GridIndex) -> Bool {
        index.column >= startIndex.column && index.column <= endIndex.column
        && index.row >= startIndex.row && index.row <= endIndex.row
    }
    init(gridElement: GridElement, startIndex: GridIndex, endIndex: GridIndex) {
        self.gridElement = gridElement
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
    init(item: GridElement, startIndex: GridIndex, span: GridSpan) {
        let endRow: Int = startIndex.row + span.row - 1
        let endColumn: Int = startIndex.column + span.column - 1
        self = .init(
            gridElement: item,
            startIndex: startIndex,
            endIndex: .init(column: endColumn, row: endRow)
        )
    }
}
@usableFromInline
internal struct GridIndex: Equatable, ExpressibleByArrayLiteral, Hashable {
    @usableFromInline
    var column: Int
    @usableFromInline
    var row: Int
    static let zero = GridIndex(column: 0, row: 0)
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    @usableFromInline
    init(arrayLiteral elements: Int...) {
        assert(elements.count == 2)
        self = GridIndex(column: elements[0], row: elements[1])
    }
}
/// Encapsulates the arranged items and total columns and rows count of a grid view
@usableFromInline
internal struct LayoutArrangement: Equatable, Hashable, CustomStringConvertible {
    @usableFromInline
    var columnsCount: Int
    @usableFromInline
    var rowsCount: Int
    let items: [ArrangedItem]
    
    static var zero = LayoutArrangement(columnsCount: 0, rowsCount: 0, items: [])
    
    subscript(gridElement: GridElement) -> ArrangedItem? {
        items.first(where: { $0.gridElement == gridElement })
    }
    @usableFromInline
    var description: String {
        guard !items.isEmpty else { return "" }
        var result = ""
        var items = self.items.map { (arrangement: $0, area: $0.area) }
        
        for row in 0...self.rowsCount {
        columnsCycle: for column in 0..<self.columnsCount {
            for (index, item) in items.enumerated() {
                if item.arrangement.contains([column, row]) {
                    result += String(item.arrangement.gridElement.debugID.uuidString.prefix(1))
                    items[index].area -= 1
                    if items[index].area == 0 {
                        items.remove(at: index)
                    }
                    continue columnsCycle
                }
            }
            result += "."
        }
            result += "\n"
        }
        
        return result
    }
}
/// Specifies the final position of a grid item in a grid view on the screen
@usableFromInline
internal struct PositionedItem: Equatable, Hashable {
    let bounds: CGRect
    let gridElement: GridElement
}

internal extension GridFlow {
    @usableFromInline
    enum Dimension: CaseIterable {
        case fixed
        case growing
    }
    @inlinable
    func index(_ dimension: Dimension) -> WritableKeyPath<GridIndex, Int> {
        switch dimension {
        case .fixed:
            return (self == .rows ? \.column : \.row)
        case .growing:
            return (self == .columns ? \.column : \.row)
        }
    }
    @inlinable
    func spanIndex(_ dimension: Dimension) -> WritableKeyPath<GridSpan, Int> {
        switch dimension {
        case .fixed:
            return (self == .rows ? \.column : \.row)
        case .growing:
            return (self == .columns ? \.column : \.row)
        }
    }
    @inlinable
    func size(_ dimension: Dimension) -> WritableKeyPath<CGSize, CGFloat> {
        switch dimension {
        case .fixed:
            return (self == .rows ? \.width : \.height)
        case .growing:
            return (self == .columns ? \.width : \.height)
        }
    }
    @inlinable
    func arrangedItemCount(_ dimension: Dimension) -> KeyPath<ArrangedItem, Int> {
        switch dimension {
        case .fixed:
            return (self == .columns ? \.rowsCount : \.columnsCount)
        case .growing:
            return (self == .rows ? \.rowsCount : \.columnsCount)
        }
    }
    @inlinable
    func arrangementCount(_ dimension: Dimension) -> WritableKeyPath<LayoutArrangement, Int> {
        switch dimension {
        case .fixed:
            return (self == .columns ? \.rowsCount : \.columnsCount)
        case .growing:
            return (self == .rows ? \.rowsCount : \.columnsCount)
        }
    }
    @inlinable
    func cgPointIndex(_ dimension: Dimension) -> WritableKeyPath<CGPoint, CGFloat> {
        switch dimension {
        case .fixed:
            return (self == .rows ? \.x : \.y)
        case .growing:
            return (self == .columns ? \.x : \.y)
        }
    }
    @inlinable
    func startIndex(_ dimension: Dimension) -> WritableKeyPath<GridStart, Int?> {
        switch dimension {
        case .fixed:
            return (self == .rows ? \.column : \.row)
        case .growing:
            return (self == .columns ? \.column : \.row)
        }
    }
}
internal extension GridTrack {
    var isIntrinsic: Bool {
        switch self {
        case .fr:
            return false
        case .pt:
            return false
        case .fit:
            return true
        }
    }
    var isFlexible: Bool {
        switch self {
        case .fr:
            return true
        case .pt:
            return false
        case .fit:
            return false
        }
    }
}
#endif
