//
//  Created by Carson Rau on 3/24/22.
//

#if canImport(SwiftUI) && !os(macOS)
import SwiftUI

@available(iOS 14.0, *)
public struct CustomAlertViewModifier<AlertContent: View>: ViewModifier {
    @ObservedObject public var customAlertManager: CustomAlertManager
    public var alertContent: () -> AlertContent
    public var buttons: [CustomAlertButton]
    public var requiresHorizontalPoisitioning: Bool {
        let maxPositioned = 2
        return buttons.count > maxPositioned
    }
    public func body(content: Content) -> some View {
        ZStack {
            content.disabled(customAlertManager.isPresented)
            if customAlertManager.isPresented {
                GeometryReader { proxy in
                    Color(.systemBackground)
                        .colorInvert()
                        .opacity(0.2)
                        .ignoresSafeArea()
                    HStack {
                        Spacer()
                        VStack {
                            let expectedWidth = proxy.size.width * 0.7
                            Spacer()
                            VStack(spacing: 0) {
                                alertContent().padding()
                                buttonsPad(expectedWidth)
                            }
                            .frame(minWidth: expectedWidth, maxWidth: expectedWidth)
                            .background(Color(.systemBackground).opacity(0.95))
                            .cornerRadius(13)
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    public func buttonsPad(_ expectedWidth: CGFloat) -> some View {
        VStack(spacing: 0) {
            if buttons.count < 1 {
                fatalError("All alerts must have atleast one button!")
            }
            if requiresHorizontalPoisitioning {
                verticalButtonsPad()
            } else {
                Divider()
                    .padding([.leading, .trailing], -12)
                horizontalButtonsPadFor(expectedWidth)
            }
        }
    }
    public func verticalButtonsPad() -> some View {
        VStack(spacing: 0) {
            ForEach(0 ..< buttons.count) {
                Divider().padding([.leading, .trailing], -12)
                let current = buttons[$0]
                Button(action: {
                    if !current.isCancel {
                        current.action()
                    }
                    withAnimation {
                        self.customAlertManager.isPresented.toggle()
                    }
                }, label: {
                    current.content
                })
                    .disabled(current.isDisabled)
                    .padding(8)
                    .frame(minHeight: 44)
            }
        }
    }
    
    public func horizontalButtonsPadFor(_ expectedWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            let offset: CGFloat = 24
            let maxHorizontalWidth = requiresHorizontalPoisitioning ? expectedWidth - offset : expectedWidth / 2 - offset
            Spacer()
            if !requiresHorizontalPoisitioning {
                ForEach(0 ..< buttons.count) {
                    if $0 != 0 {
                        Divider().frame(height: 44)
                        let current = buttons[$0]
                        Button {
                            if !current.isCancel {
                                current.action()
                            }
                            withAnimation {
                                self.customAlertManager.isPresented.toggle()
                            }
                        } label: {
                            current.content
                        }
                        .disabled(current.isDisabled)
                        .padding(8)
                        .frame(maxWidth: maxHorizontalWidth, minHeight: 44)
                    }
                }
            }
            Spacer()
        }
    }
}

#if os(watchOS)
fileprivate extension UIColor {
    static var systemBackgoround: UIColor {
        UIColor(.black)
    }
}
#endif
#endif
