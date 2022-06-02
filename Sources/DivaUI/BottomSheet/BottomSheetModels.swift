//
// Created by Carson Rau on 3/27/22.
//

import SwiftUI

// MARK: - Views
public struct BottomSheetHandle: View {
    private let style: BottomSheetHandleStyle
    public init(style: BottomSheetHandleStyle = .standard) {
        self.style = style
    }
    public var body: some View {
        RoundedRectangle(cornerRadius: style.cornerRadius)
            .fill(style.handleColor)
            .frame(width: style.size.width, height: style.size.height)
    }
}

public struct BottomSheetHandleBar: View {
    private let style: BottomSheetHandleStyle
    public init(style: BottomSheetHandleStyle = .standard) {
        self.style = style
    }
    public var body: some View {
        VStack(spacing: 0) {
            BottomSheetHandle(style: style)
                .withHandlePadding(in: style)
            Divider()
                .background(style.dividerColor)
        }
        .background(style.backgroundColor)
    }
}

fileprivate extension View {
    @ViewBuilder
    func withHandlePadding(in style: BottomSheetHandleStyle) -> some View {
        if let padding = style.padding {
            self.padding(padding)
        } else {
            self.padding()
        }
    }
}

// MARK: - Styles
public struct BottomSheetHandleStyle {
    public var backgroundColor: Color
    public var cornerRadius: CGFloat
    public var dividerColor: Color?
    public var handleColor: Color
    public var padding: EdgeInsets?
    public var size: CGSize
    
    public static var standard: BottomSheetHandleStyle { .init() }
    public init(
            handleColor: Color = Color.secondary,
            backgroundColor: Color = Color.primary.opacity(0.02),
            dividerColor: Color? = Color.primary.opacity(0.1),
            width: CGFloat = 50,
            height: CGFloat = 6,
            padding: EdgeInsets? = nil,
            cornerRadius: CGFloat = 16
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.dividerColor = dividerColor
        self.handleColor = handleColor
        self.padding = padding
        self.size = CGSize(width: width, height: height)
    }
}

public struct BottomSheetStyle {
    public typealias Modifier = (AnyView) -> AnyView
    public var color: Color
    public var cornerRadius: CGFloat
    public var handleStyle: BottomSheetHandleStyle
    public var modifier: (AnyView) -> AnyView
    public var snapRatio: CGFloat
    
    public static var standard: BottomSheetStyle { .init() }
    
    public init(
        color: Color = Color("bottomSheet", bundle: Bundle(for: _SheetToken.self)),
            cornerRadius: CGFloat = 16,
            modifier: @escaping Modifier = BottomSheetStyle.standardModifier,
            snapRatio: CGFloat = 0.25,
            handleStyle: BottomSheetHandleStyle = .standard
    ) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.modifier = modifier
        self.snapRatio = snapRatio
        self.handleStyle = handleStyle
    }
    
    public static func standardModifier(view: AnyView) -> AnyView {
        .init(view.shadow(color: .black.opacity(0.2), radius: 5))
    }
}

public enum BottomSheetHeight {
    case available
    case percentage(CGFloat)
    case points(CGFloat)
}

// MARK: - Helpers
public final class _SheetToken { }
