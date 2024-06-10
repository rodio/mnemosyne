//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

struct Card : View {
    @Binding var degree : Double
    public var color : Color
    public var text : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color)
            
            Text(text)
                .font(.title)
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
        DragGesture()
            .onChanged({ gesture in
                offset = gesture.translation})
            .onEnded(
                { gesture in
                    if gesture.translation.width < -150 {
                        withAnimation(.snappy(duration: 0.9)) {
                                offset = CGSize(width: -1500, height: 0)
                            } completion: {
                                offset = CGSizeZero
                            }
                        
                    } else {
                        withAnimation(.snappy(duration: 0.2)){
                            offset = CGSize.zero
                        }
                    }
                })
    }
    
    var body : some View {
        ZStack {
            Card(degree: $frontDegree, color: .mint, text: "Front")
            Card(degree: $backDegree, color: .teal, text: "Back")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(50)
        .onTapGesture(perform: flipCard)
        .offset(offset)
        .gesture(
            simpleDrag
        )
        
    }
}


struct ContentView: View {
    var body = TwoCards()
}

#Preview {
    ContentView()
}
