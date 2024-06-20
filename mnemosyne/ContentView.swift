//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

let lightBackgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.2), Color.mint.opacity(0.15)]), startPoint: .topTrailing, endPoint: .leading)

let darkBackgroundGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.1), Color.orange.opacity(0.2)]), startPoint: .topTrailing, endPoint: .leading)

let lightFrontGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.15), Color.mint.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)

let lightBackGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.15), Color.mint.opacity(0.2)]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkFrontGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.orange.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)

let darkBackGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.orange.opacity(0.4)]), startPoint: .bottomTrailing, endPoint: .topLeading)

struct ContentView: View {
    var body = DeckList()
}

#Preview {
    ContentView()
}
