//
//  Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

@available(iOS 14.0, *)
public struct CustomAlertButton {
    public enum Variant {
        case cancel
        case regular
    }
    public let content: AnyView
    public let action: () -> Void
    public let type: Variant
    public let isDisabled: Bool
    public var isCancel: Bool { type == .cancel }
    
    public static func cancel<Content: View>(@ViewBuilder content: @escaping () -> Content) -> CustomAlertButton {
        .init(content: content, action: { }, type: .cancel)
    }
    
    public static func regular<Content: View>(
        @ViewBuilder content: @escaping () -> Content,
        action: @escaping () -> Void,
        type: Variant,
        isDisabled: Bool = false
    ) -> CustomAlertButton {
        .init(content: content, action: action, type: type, isDisabled: isDisabled)
    }
    
    public init<Content: View>(
        @ViewBuilder content: @escaping () -> Content,
        action: @escaping () -> Void,
        type: Variant,
        isDisabled: Bool = false
    ) {
        self.content = AnyView(content())
        self.type = type
        self.action = action
        self.isDisabled = isDisabled
    }
    
    
}
#endif
