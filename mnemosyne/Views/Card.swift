//
//  Card.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import SwiftData
import SwiftUI

struct Card: View {
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    @State private var offset = CGSize.zero
    let flipDuration: CGFloat = 0.08
    @Environment(\.colorScheme) var colorScheme
    public var cardModel: CardModel

    var body: some View {
        ZStack {
            CardSide(degree: $frontDegree, gradient: colorScheme == .dark ? darkGradient : lightGradient, text: cardModel.frontText)
            CardSide(degree: $backDegree, gradient: colorScheme == .dark ? darkBackGradient : lightBackGradient, text: cardModel.backText)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(EdgeInsets(top: 40, leading: 50, bottom: 40, trailing: 50))
        .onTapGesture(perform: flipCard)
        .offset(offset)
        .gesture(
            simpleDrag
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func flipCard() {
        if !isFlipped {
            withAnimation(.linear(duration: flipDuration)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: flipDuration).delay(flipDuration)) {
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: flipDuration).delay(flipDuration)) {
                frontDegree = 0
            }
            withAnimation(.linear(duration: flipDuration)) {
                backDegree = -90
            }
        }
        isFlipped.toggle()
    }

    private var simpleDrag: some Gesture {
        enum SwipeDirection {
            case left
            case right
            case up
            case down
            case none
        }

        var direction = SwipeDirection.none

        return DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { gesture in
                if gesture.translation.width < -180 {
                    direction = SwipeDirection.left
                } else if gesture.translation.width > 180 {
                    direction = SwipeDirection.right
                } else if gesture.translation.height > 180 {
                    direction = SwipeDirection.up
                } else if gesture.translation.height < -180 {
                    direction = SwipeDirection.down
                } else {
                    direction = SwipeDirection.none
                }

                let swipeOffset: CGSize
                switch direction {
                case .left:
                    swipeOffset = CGSize(width: -1500, height: 0)
                case .right:
                    swipeOffset = CGSize(width: 1500, height: 0)
                case .down:
                    swipeOffset = CGSize(width: 0, height: -1500)
                case .up:
                    swipeOffset = CGSize(width: 0, height: 1500)
                default:
                    swipeOffset = CGSize(width: 0, height: 0)
                }

                withAnimation(.snappy(duration: 0.9)) {
                    offset = swipeOffset
                }
            }
    }

    private struct CardSide: View {
        @Binding public var degree: Double
        public var gradient: LinearGradient
        public var text: String

        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(gradient)
                    .shadow(radius: 5)

                Text(text)
                    .font(.largeTitle)
                    .onTapGesture {}
                    .fontWidth(.expanded)
            }
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        }
    }
}
