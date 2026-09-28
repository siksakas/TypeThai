//
//  ChunkyButtonStyle.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/27/26.
//
import SwiftUI
import AVFoundation

enum TT {
    static let bg           = Color(hex: 0x28204A)
    static let bgBlob       = Color(hex: 0x352B5E)
    static let surface      = Color(hex: 0x3A3063)
    static let badge        = Color(hex: 0x463B7A)
    static let badgeText    = Color(hex: 0xCFC4FF)
    static let yellow       = Color(hex: 0xFFCD60)
    static let yellowDeep   = Color(hex: 0xE9A93A)
    static let mint         = Color(hex: 0x5ED6B0)
    static let lavender     = Color(hex: 0xE9E2FF)
    static let lavenderMid  = Color(hex: 0xB9A8F5)
    static let lavenderDeep = Color(hex: 0x6552B8)
    static let pink         = Color(hex: 0xC77DFF)
    static let card         = Color(hex: 0xFCF9F4)
    static let ink          = Color(hex: 0x1B1730)
    static let muted        = Color(hex: 0x8B8799)
    static let peach        = Color(hex: 0xFCE3D8)
    static let cream        = Color(hex: 0xFDF1D9)
    static let dotOff       = Color(hex: 0x4A4175)

    static func rounded(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .rounded)
    }
}

struct ChunkyButtonStyle: ButtonStyle {
    private let depth: CGFloat = 7

    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        configuration.label
            .font(TT.rounded(20, .bold))
            .foregroundStyle(TT.ink)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.customYellow, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .offset(y: pressed ? depth : 0)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.customYellowDeep)
                    .offset(y: 7)
            )
            .padding(.bottom, depth)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: pressed)
    }
}

//struct PressScaleStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.96 : 1)
//            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
//    }
//}
