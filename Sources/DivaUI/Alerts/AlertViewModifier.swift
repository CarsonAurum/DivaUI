//
// Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

public struct AlertViewModifier: ViewModifier {
    @ObservedObject public var alertManager: AlertManager
    
    public func body(content: Content) -> some View {
        content
                .alert(item: $alertManager.alertItem) {
                    if $0.dismiss != nil {
                        if let type = $0.dismiss {
                            return .init(
                                    title: Text(type.title),
                                    message: Text(type.message),
                                    dismissButton: type.dismissButton
                            )
                        } else {
                            return .init(
                                    title: Text("Error"),
                                    message: Text("Something went terribly wrong."),
                                    dismissButton: .cancel(Text("OK"))
                            )
                        }
                    } else if $0.primarySecondary != nil {
                        if let type = $0.primarySecondary {
                            return .init(
                                    title: Text(type.title),
                                    message: Text(type.message),
                                    primaryButton: type.primaryButton ?? .default(Text("OK")),
                                    secondaryButton: type.secondaryButton ?? .cancel()
                            )
                        } else {
                            return .init(
                                    title: Text("Error"),
                                    message: Text("Something went terribly wrong."),
                                    dismissButton: .cancel(Text("OK"))
                            )
                        }
                    } else {
                        return .init(
                                title: Text("Error"),
                                message: Text("Something went terribly wrong."),
                                dismissButton: .cancel(Text("OK"))
                        )
                    }
                }
                .actionSheet(item: $alertManager.actionSheetItem) {
                    let type = $0.defaultActionSheet
                    return ActionSheet(
                            title: Text(type.title),
                            message: Text(type.message),
                            buttons: type.buttons
                    )
                }
    }
}
#endif
