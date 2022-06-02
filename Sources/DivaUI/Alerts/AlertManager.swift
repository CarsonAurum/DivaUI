//
// Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

public class AlertManager: ObservableObject {
    @Published public var alertItem: AlertItem?
    @Published public var actionSheetItem: ActionSheetItem?
    
    public init() { }
    
    public func show(dismiss: AlertItem.Dismiss) {
        alertItem = .init(dismiss: dismiss, primarySecondary: nil)
    }
    public func show(primarySecondary: AlertItem.PrimarySecondary) {
        alertItem = .init(dismiss: nil, primarySecondary: primarySecondary)
    }
    public func showActionSheet(_ sheet: ActionSheetItem.DefaultActionSheet) {
        actionSheetItem = .init(defaultActionSheet: sheet)
    }
}
#endif
