//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

let lightGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.mint.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)

let lightBackGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.mint.opacity(0.2)]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.orange.opacity(0.4)]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkBackGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.3), Color.orange.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct ContentView: View {
    var body = DeckList()
}

#Preview {
    ContentView()
}
