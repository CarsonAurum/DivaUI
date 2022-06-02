//
// Created by Carson Rau on 7/24/21.
//

import SwiftUI

internal struct IdentifiedView {
  var hash: AnyHashable?
  let view: AnyView
}

protocol GridForEachRangeInt {
  var contentViews: [IdentifiedView] { get }
}

protocol GridForEachIdentifiable {
  var contentViews: [IdentifiedView] { get }
}

protocol GridForEachID {
  var contentViews: [IdentifiedView] { get }
}

protocol GridGroupContaining {
  var contentViews: [IdentifiedView] { get }
}
