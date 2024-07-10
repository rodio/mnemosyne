//
//  CardView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import SwiftData
import SwiftUI
import Observation

struct CardView: View {
    @State var backDegree = -90.0
    @State var frontDegree = 0.0
    @State var isFlipped = false
    @State private var offset = CGSize.zero
    let flipDuration: CGFloat = 0.06
    @Environment(\.colorScheme) var colorScheme
    
    public var cardViewModelManager: CardViewModelManager
    @State public var cardViewModel: CardViewModel
    
    var body: some View {
        ZStack {
            CardBackground(degree: $frontDegree)
            CardBackground(degree: $backDegree)
            CardSide(degree: $frontDegree, gradient: colorScheme == .dark ? darkGradient : lightGradient, text: cardViewModel.cardModel.frontText)
            CardSide(degree: $backDegree, gradient: colorScheme == .dark ? darkBackGradient : lightBackGradient, text: cardViewModel.cardModel.backText)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 40, trailing: 20))
        // TODO check not blurred on tap
        .onTapGesture(perform: flipCard)
        .offset(offset)
        .rotationEffect(Angle(degrees: offset.width*0.05))
        .gesture(
            simpleDrag
        )
        .blur(radius: cardViewModel.isFront ? 0.0 : 3.0)
    }
    
    private func flipCard() {
        if !cardViewModel.isFront {
            return
        }
        
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
    
    enum CardDirection {
        case left
        case right
        case up
        case down
        case none
    }
    
    @State var swipeDirection = CardDirection.none
    @State var dragDirection = CardDirection.none
    
    private func getDragDirection(translation: CGSize) -> CardDirection {
        if abs(translation.width) * 1.5 > abs(translation.height) {
            if translation.width < 0 {
                return .left
            }
            return .right
        }
        
        if translation.height > 10 {
            return .up
        }
        return .down
    }
    
    private var simpleDrag: some Gesture {
        return DragGesture()
            .onChanged { gesture in
                if dragDirection == .none {
                    dragDirection = getDragDirection(translation: gesture.translation)
                }
                
                if dragDirection == .left || dragDirection == .right {
                    offset = CGSize(width: gesture.translation.width, height: 0)
                } else {
                    if dragDirection == .down || dragDirection == .up {
                        offset = CGSize(width: 0, height: gesture.translation.height)
                    } else {
                        withAnimation(.snappy) {
                            offset = CGSize.zero
                        }
                    }
                }
            }
            .onEnded { gesture in
                dragDirection = .none
                
                if gesture.translation.width < -180 {
                    swipeDirection = CardDirection.left
                } else if gesture.translation.width > 180 {
                    swipeDirection = CardDirection.right
                } else if gesture.translation.height > 180 {
                    swipeDirection = CardDirection.up
                } else if gesture.translation.height < -180 {
                    swipeDirection = CardDirection.down
                } else {
                    swipeDirection = CardDirection.none
                }
                
                let swipeOffset: CGSize
                switch swipeDirection {
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
                
                withAnimation(.snappy(duration: 0.1)) {
                    offset = swipeOffset
                } completion: {
                    if swipeDirection != .none {
                        cardViewModelManager.removeCardViewModel(cardViewModel: cardViewModel)
                    }
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
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0.01))
        }
    }
    
    private struct CardBackground: View {
        @Binding public var degree: Double
        @Environment(\.colorScheme) var colorScheme
        
        var body: some View {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
                .shadow(radius: 5)
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0.01))
        }
    }
}
