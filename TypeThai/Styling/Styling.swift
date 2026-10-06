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

struct RaisedButtonStyle: ButtonStyle {
    var face: Color = .offWhite
    var shadow: Color = .offWhiteShadow
    var cornerRadius: CGFloat = 16
    var depth: CGFloat = 5

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                face,
                in: RoundedRectangle(cornerRadius: cornerRadius)
            )
            .offset(y: configuration.isPressed ? depth : 0)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(shadow)
                    .offset(y: depth)
            )
            .padding(.bottom, depth)
            .animation(
                .spring(response: 0.1, dampingFraction: 0.7),
                value: configuration.isPressed
            )
    }
}
