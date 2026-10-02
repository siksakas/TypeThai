//
//  ChunkyButtonStyle.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/27/26.
//
import SwiftUI
import AVFoundation

enum TT {
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
            .foregroundStyle(Color.ink)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(Color.offWhite, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .offset(y: pressed ? depth : 0)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.offWhiteShadow)
                    .offset(y: 7)
            )
            .padding(.bottom, depth)
            .animation(.spring(response: 0.1, dampingFraction: 0.7), value: pressed)
            .sensoryFeedback(.success, trigger: pressed)
    }
}

//struct PressScaleStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 0.96 : 1)
//            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: configuration.isPressed)
//    }
//}
