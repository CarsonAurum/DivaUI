//
//  Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

@available(iOS 14.0, *)
public class CustomAlertManager: ObservableObject {
    @Published public var isPresented: Bool
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    public func show() {
        withAnimation {
            isPresented = true
        }
    }
    public func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
}
#endif
