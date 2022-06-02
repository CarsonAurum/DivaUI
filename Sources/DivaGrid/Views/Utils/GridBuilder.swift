//
// Created by Carson Rau on 7/24/21.
//

import SwiftUI

public struct _ConstructedView: View {
    static var empty = _ConstructedView(contentViews: [])
    public var body = EmptyView()
    var contentViews: [IdentifiedView]
}

@resultBuilder
public struct GridBuilder {
    public static func buildBlock() -> _ConstructedView {
        return _ConstructedView(contentViews: [])
    }
    public static func buildBlock<A: View>(_ content: A) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: content.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    public static func buildBlock<A: View, B: View>(
        _ c0: A, _ c1: B
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View>(
        _ c0: A, _ c1: B, _ c2: C
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E
    )-> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View, F: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E, _ c5: F
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        views.append(contentsOf: c5.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View, F: View, G: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E, _ c5: F, _ c6: G
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        views.append(contentsOf: c5.extractContentViews())
        views.append(contentsOf: c6.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E, _ c5: F, _ c6: G, _ c7: H
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        views.append(contentsOf: c5.extractContentViews())
        views.append(contentsOf: c6.extractContentViews())
        views.append(contentsOf: c7.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E, _ c5: F, _ c6: G, _ c7: H, _ c8: I
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        views.append(contentsOf: c5.extractContentViews())
        views.append(contentsOf: c6.extractContentViews())
        views.append(contentsOf: c7.extractContentViews())
        views.append(contentsOf: c8.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildBlock<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View, J: View>(
        _ c0: A, _ c1: B, _ c2: C, _ c3: D, _ c4: E, _ c5: F, _ c6: G, _ c7: H, _ c8: I, _ c9: J
    ) -> _ConstructedView {
        var views: [IdentifiedView] = []
        views.append(contentsOf: c0.extractContentViews())
        views.append(contentsOf: c1.extractContentViews())
        views.append(contentsOf: c2.extractContentViews())
        views.append(contentsOf: c3.extractContentViews())
        views.append(contentsOf: c4.extractContentViews())
        views.append(contentsOf: c5.extractContentViews())
        views.append(contentsOf: c6.extractContentViews())
        views.append(contentsOf: c7.extractContentViews())
        views.append(contentsOf: c8.extractContentViews())
        views.append(contentsOf: c9.extractContentViews())
        return _ConstructedView(contentViews: views)
    }
    
    public static func buildEither(first: _ConstructedView) -> _ConstructedView {
        first
    }
    
    public static func buildEither(second: _ConstructedView) -> _ConstructedView {
        second
    }
    
    public static func buildIf(_ content: _ConstructedView?) -> _ConstructedView {
        return content ?? _ConstructedView(contentViews: [])
    }
}
