//
//  View+Corner.swift
//  Nova
//
//  Created by huanghong on 8/26/24.
//  Copyright © 2024 Fooman Inc. All rights reserved.
//

import Foundation

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    /// 给一个View的四个角设置独立的圆角
    func customUnevenRoundedRectangle(topLeadingRadius: CGFloat = 0, bottomLeadingRadius: CGFloat = 0, bottomTrailingRadius: CGFloat = 0, topTrailingRadius: CGFloat = 0) -> some View {
        self.modifier(CustomUnevenRoundedRectangleModifier(topLeadingRadius: topLeadingRadius, bottomLeadingRadius: bottomLeadingRadius, bottomTrailingRadius: bottomTrailingRadius, topTrailingRadius: topTrailingRadius))
    }
}

/// 给一个View的四个角设置独立的圆角
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct CustomUnevenRoundedRectangleModifier: ViewModifier {
    var topLeadingRadius: CGFloat
    var bottomLeadingRadius: CGFloat
    var topTrailingRadius: CGFloat
    var bottomTrailingRadius: CGFloat

    public init(topLeadingRadius: CGFloat, bottomLeadingRadius: CGFloat, bottomTrailingRadius: CGFloat, topTrailingRadius: CGFloat) {
        self.topLeadingRadius = topLeadingRadius
        self.bottomLeadingRadius = bottomLeadingRadius
        self.bottomTrailingRadius = bottomTrailingRadius
        self.topTrailingRadius = topTrailingRadius
    }

    func body(content: Content) -> some View {
        content
            .mask {
                if #available(iOS 16.0, *) {
                    UnevenRoundedRectangle(topLeadingRadius: topLeadingRadius, bottomLeadingRadius: bottomLeadingRadius, bottomTrailingRadius: bottomTrailingRadius, topTrailingRadius: topTrailingRadius)
                } else {
                    CustomUnevenRoundedRectangle(topLeadingRadius: topLeadingRadius, bottomLeadingRadius: bottomLeadingRadius, bottomTrailingRadius: bottomTrailingRadius, topTrailingRadius: topTrailingRadius)
                }
            }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
struct CustomUnevenRoundedRectangle: Shape {
    var topLeadingRadius: CGFloat = 0.0
    var bottomLeadingRadius: CGFloat = 0.0
    var bottomTrailingRadius: CGFloat = 0.0
    var topTrailingRadius: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        let tr = min(min(self.topTrailingRadius, h/2), w/2)
        let tl = min(min(self.topLeadingRadius, h/2), w/2)
        let bl = min(min(self.bottomLeadingRadius, h/2), w/2)
        let br = min(min(self.bottomTrailingRadius, h/2), w/2)

        path.move(to: CGPoint(x: w/2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
