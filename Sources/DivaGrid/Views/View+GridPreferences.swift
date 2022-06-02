//
//  Created by Carson Rau on 7/24/21.
//

import SwiftUI
import DivaCore

extension View {
  public func gridSpan(column: Int = GridDefaults.columnSpan,
                       row: Int = GridDefaults.rowSpan
  ) -> some View {
    transformPreference(GridPreferenceKey.self, { preferences in
      var info = preferences.itemsInfo.first ?? .empty
      info.span = GridSpan(column: max(column, 1), row: max(row, 1))
      preferences.itemsInfo = [info]
    })
  }
  
  public func gridSpan(_ span: GridSpan) -> some View {
    transformPreference(GridPreferenceKey.self, { preferences in
      var info = preferences.itemsInfo.first ?? .empty
      info.span = GridSpan(column: max(span.column, 1), row: max(span.row, 1))
      preferences.itemsInfo = [info]
    })
  }
  
  public func gridStart(column: Int? = nil, row: Int? = nil) -> some View {
    transformPreference(GridPreferenceKey.self, { preferences in
      var info = preferences.itemsInfo.first ?? .empty
      info.start = GridStart(column: column.nilIfBelowZero, row: row.nilIfBelowZero)
      preferences.itemsInfo = [info]
    })
  }
  
  public func gridStart(_ start: GridStart) -> some View {
    transformPreference(GridPreferenceKey.self, { preferences in
      var info = preferences.itemsInfo.first ?? .empty
      info.start = GridStart(column: start.column.nilIfBelowZero, row: start.row.nilIfBelowZero)
      preferences.itemsInfo = [info]
    })
  }
  
  public func gridItemAlignment(_ alignment: GridAlignment) -> some View {
    transformPreference(GridPreferenceKey.self, { preferences in
      var info = preferences.itemsInfo.first ?? .empty
      info.alignment = alignment
      preferences.itemsInfo = [info]
    })
  }
  
  public func gridCellOverlay<Content: View>(
    @ViewBuilder content: @escaping (CGSize?) -> Content
  ) -> some View {
    preference(
      key: GridOverlayPreferenceKey.self,
      value: GridOverlayPreference { rect in
        AnyView(content(rect))
      }
    )
  }
  
  public func gridCellBackground<Content: View>(
    @ViewBuilder content: @escaping (CGSize?) -> Content
  ) -> some View {
    preference(
      key: GridBackgroundPreferenceKey.self,
      value: GridBackgroundPreference { rect in
        AnyView(content(rect))
      })
  }
}
