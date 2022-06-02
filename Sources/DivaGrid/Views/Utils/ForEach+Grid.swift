//
// Created by Carson Rau on 7/24/21.
//

import SwiftUI

extension ForEach: GridForEachRangeInt where Data == Range<Int>, ID == Int, Content: View {
    var contentViews: [IdentifiedView] {
        self.data.flatMap { self.content($0).extractContentViews() }
    }
}
extension ForEach: GridForEachIdentifiable where ID == Data.Element.ID, Content: View, Data.Element: Identifiable {
    var contentViews: [IdentifiedView] {
        self.data.enumerated().flatMap { (_, dataElement) -> [IdentifiedView] in
            let view = self.content(dataElement)
            return view.extractContentViews().enumerated().map {
                var indentifiedView = $0.1
                if let identifiedHash = indentifiedView.hash {
                    indentifiedView.hash = AnyHashable([identifiedHash,
                                                        AnyHashable(dataElement.id)])
                } else {
                    indentifiedView.hash = AnyHashable([AnyHashable(dataElement.id),
                                                        AnyHashable($0.0)])
                }
                return indentifiedView
            }
        }
    }
}
extension ForEach: GridForEachID where Content: View {
    var contentViews: [IdentifiedView] {
        self.data.flatMap { self.content($0).extractContentViews() }
    }
}
#if DEBUG
extension ModifiedContent: GridForEachRangeInt
where Content: GridForEachRangeInt, Modifier == _IdentifiedModifier<__DesignTimeSelectionIdentifier> {
    var contentViews: [IdentifiedView] {
        return self.content.contentViews
    }
}
extension ModifiedContent: GridForEachIdentifiable
where Content: GridForEachIdentifiable, Modifier == _IdentifiedModifier<__DesignTimeSelectionIdentifier> {
    var contentViews: [IdentifiedView] {
        return self.content.contentViews
    }
}
extension ModifiedContent: GridForEachID
where Content: GridForEachID, Modifier == _IdentifiedModifier<__DesignTimeSelectionIdentifier> {
    var contentViews: [IdentifiedView] {
        return self.content.contentViews
    }
}
#endif
