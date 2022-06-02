//
//  Created by Carson Rau on 3/27/22.
//

import SwiftUI

public extension View {
    func bottomSheet<Sheet: BottomSheetView>(_ sheet: Sheet) -> some View {
        ZStack {
            self
            sheet
        }
    }
    @ViewBuilder
    func bottomSheet<Sheet: BottomSheetView>(_ sheet: Sheet, if condition: Bool) -> some View {
        if condition {
            self.bottomSheet(sheet)
        } else {
            self
        }
    }
}

public protocol BottomSheetView: View { }

public struct BottomSheet<Content: View>: BottomSheetView {
    private let content: Content
    private let maxHeight: BottomSheetHeight
    private let minHeight: BottomSheetHeight
    private let style: BottomSheetStyle
    
    @Binding private var isExpanded: Bool
    @GestureState private var translation: CGFloat = 0
    
    public init(
        isExpanded: Binding<Bool>,
        minHeight: BottomSheetHeight = .points(100),
        maxHeight: BottomSheetHeight = .available,
        style: BottomSheetStyle = .standard,
        @ViewBuilder content: () -> Content
    ) {
        self._isExpanded = isExpanded
        self.maxHeight = maxHeight
        self.minHeight = minHeight
        self.style = style
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                handle(for: proxy)
                contentView(for: proxy)
            }
            .frame(width: proxy.size.height, height: maxHeight(in: proxy), alignment: .top)
            .background(style.color)
            .cornerRadius(style.cornerRadius)
            .modified(with: style.modifier)
            .frame(height: proxy.size.height + proxy.safeAreaInsets.bottom, alignment: .bottom)
            .offset(y: max(offset(for: proxy) + translation, 0))
            .animation(.interactiveSpring())
        }
    }
    
    // MARK: - Helpers
    private func contentView(for geo: GeometryProxy) -> some View {
        content.padding(.bottom, geo.safeAreaInsets.bottom)
    }
    private func handle(for geo: GeometryProxy) -> some View {
        BottomSheetHandleBar(style: style.handleStyle)
            .onTapGesture(perform: toggleIsExpanded)
            .gesture(
                DragGesture()
                    .updating($translation) { val, state, _ in state = val.translation.height }
                    .onEnded {
                        let translationHeight = abs($0.translation.height)
                        let snapDistance = maxHeight(in: geo) * style.snapRatio
                        guard translationHeight > snapDistance else { return }
                        isExpanded = $0.translation.height < 0
                    }
            )
    }
    private func height(of height: BottomSheetHeight, in geo: GeometryProxy) -> CGFloat {
        switch height {
        case .available:
            return geo.size.height + geo.safeAreaInsets.bottom
        case let .percentage(ratio):
            return ratio * (geo.size.height + geo.safeAreaInsets.bottom)
        case let .points(points):
            return points
        }
    }
    private func minHeight(in geo: GeometryProxy) -> CGFloat {
        height(of: minHeight, in: geo)
    }
    private func maxHeight(in geo: GeometryProxy) -> CGFloat {
        height(of: maxHeight, in: geo)
    }
    private func offset(for geo: GeometryProxy) -> CGFloat {
        isExpanded ? 0 : maxHeight(in: geo) - minHeight(in: geo)
    }
    private func toggleIsExpanded() {
        isExpanded.toggle()
    }
}

fileprivate extension View {
    func modified(with modifier: (AnyView) -> AnyView) -> some View {
        modifier(AnyView(self))
    }
}
