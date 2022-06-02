//
//  Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

extension View {
    public func uses(_ alertManager: AlertManager) -> some View {
        self.modifier(AlertViewModifier(alertManager: alertManager))
    }
    @available(iOS 14.0, *)
    public func customAlert<AlertContent: View>(
        manager: CustomAlertManager,
        content: @escaping () -> AlertContent,
        buttons: [CustomAlertButton]
    ) -> some View {
        self.modifier(CustomAlertViewModifier(customAlertManager: manager, alertContent: content, buttons: buttons))
    }
}

#endif
