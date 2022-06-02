//
//  Created by Carson Rau on 7/24/21.
//

import SwiftUI

public struct GridGroup: View, GridGroupContaining {
    public static var empty = GridGroup(contentViews: [])
    var contentViews: [IdentifiedView]
    public var body = EmptyView()
    // MARK: - Inits
    internal init(contentViews: [IdentifiedView]) {
        self.contentViews = contentViews
    }
    public init(@GridBuilder content: () -> _ConstructedView) {
      self.contentViews = content().contentViews
    }
    public init<Data, ID>(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        @GridBuilder item: @escaping (Data.Element) -> _ConstructedView
    ) where Data: RandomAccessCollection, ID: Hashable {
      self.contentViews = data.enumerated().flatMap { (_, dataElement: Data.Element) -> [IdentifiedView] in
        let constructionItem = item(dataElement)
        let views: [IdentifiedView] = constructionItem.contentViews.enumerated().map {
          var identifiedView = $0.1
          if let identifiedHash = identifiedView.hash {
            identifiedView.hash =
              AnyHashable([identifiedHash,
                           AnyHashable(dataElement[keyPath: id]),
                           AnyHashable(id)])
          } else {
            identifiedView.hash =
              AnyHashable([AnyHashable(dataElement[keyPath: id]),
                           AnyHashable(id),
                           AnyHashable($0.0)])
          }
          return identifiedView
        }
        return views
      }
    }

    public init(_ data: Range<Int>, @GridBuilder item: @escaping (Int) -> _ConstructedView) {
      self.contentViews = data.flatMap { item($0).contentViews }
    }
    public init<Data>(
        _ data: Data,
        @GridBuilder item: @escaping (Data.Element) -> _ConstructedView
    ) where Data: RandomAccessCollection, Data.Element: Identifiable {
      self.contentViews = data.enumerated().flatMap { (_, dataElement: Data.Element) -> [IdentifiedView] in
        let constructionItem = item(dataElement)
        let views: [IdentifiedView] = constructionItem.contentViews.enumerated().map {
          var identifiedView = $0.1
          if let identifiedHash = identifiedView.hash {
            identifiedView.hash =
              AnyHashable([identifiedHash,
                           dataElement.id])
          } else {
            identifiedView.hash =
              AnyHashable([AnyHashable(dataElement.id),
                           AnyHashable($0.0)])
          }
          return identifiedView
        }
        return views
      }
    }

    public init<Data: Identifiable>(_ data: Data, @GridBuilder item: @escaping (Data) -> _ConstructedView) {
      self.init([data], item: item)
    }

    public init<Data: Hashable>(_ data: Data, @GridBuilder item: @escaping (Data) -> _ConstructedView) {
      self.init([data], id: \.self, item: item)
    }
}

#if DEBUG
// To be available on preview canvas
extension ModifiedContent: GridGroupContaining
        where Content: GridGroupContaining, Modifier == _IdentifiedModifier<__DesignTimeSelectionIdentifier> {
    var contentViews: [IdentifiedView] {
        return self.content.contentViews
    }
}
#endif
