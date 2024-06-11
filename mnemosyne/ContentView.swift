//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

struct Card : View {
    @Binding var degree : Double
    public var gradient : LinearGradient
    public var text : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(gradient)
                .shadow(radius: 5)
            
            Text(text)
                .font(.largeTitle)
                .fontDesign(.monospaced)
                .fontWidth(.expanded)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0.001))
    }
}

struct TwoCards: View {
    @State var backDegree = -90.0
    @State var frontDegree = 0.00001
    @State var isFlipped = false
    
    @State private var offset = CGSize.zero
    let flipDuration : CGFloat = 0.08
    
    func flipCard() {
        if !isFlipped {
            withAnimation(.linear(duration: flipDuration)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: flipDuration).delay(flipDuration)){
                backDegree = 0
            }
        } else {
            withAnimation(.linear(duration: flipDuration).delay(flipDuration)) {
                frontDegree = 0
            }
            withAnimation(.linear(duration: flipDuration)){
                backDegree = -90
            }
        }
        isFlipped.toggle()
    }
    
    public var simpleDrag: some Gesture {
        enum SwipeDirection {
            case left
            case right
            case up
            case down
            case none
        }
        
        var direction = SwipeDirection.none
        
        return DragGesture()
            .onChanged(
                { gesture in
                offset = gesture.translation
            })
            .onEnded(
                { gesture in
                    if gesture.translation.width < -180 {
                        direction = SwipeDirection.left;
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
                        swipeOffset =  CGSize(width: 1500, height: 0)
                    case .down:
                        swipeOffset =  CGSize(width: 0, height: -1500)
                    case .up:
                        swipeOffset =  CGSize(width: 0, height: 1500)
                    default:
                        swipeOffset = CGSizeZero
                    }
                    
                    withAnimation(.snappy(duration: 0.9)) {
                        offset = swipeOffset
                    } completion: {
                        offset = CGSizeZero
                    }
                })
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    let lightBackgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.2), Color.mint.opacity(0.15)]), startPoint: .topTrailing, endPoint: .leading)
    
    let darkBackgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.orange.opacity(0.4)]), startPoint: .topTrailing, endPoint: .leading)
    
    let lightFrontGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.15), Color.mint.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    let lightBackGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.15), Color.mint.opacity(0.2)]), startPoint: .bottomTrailing, endPoint: .topLeading)

    let darkFrontGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.08), Color.orange.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    let darkBackGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.4), Color.orange.opacity(0.3)]), startPoint: .bottomTrailing, endPoint: .topLeading)
    
    
    var body : some View {
        ZStack {
            ZStack {
                Card(degree: $frontDegree, gradient: colorScheme == .dark ? darkFrontGradient : lightFrontGradient, text: "Front")
                Card(degree: $backDegree, gradient: colorScheme == .dark ? darkBackGradient : lightBackGradient , text: "Back")
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(EdgeInsets(top: 60, leading: 50, bottom: 40, trailing: 50))
            .onTapGesture(perform: flipCard)
            .offset(offset)
            .gesture(
                simpleDrag
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(colorScheme == .light ? lightBackgroundGradient : darkBackgroundGradient)
    }
}


struct ContentView: View {
    var body = TwoCards()
}

#Preview {
    ContentView()
}
