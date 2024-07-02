//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

let lightGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.mint.opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)

let lightBackGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.mint.opacity(0.2)]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.orange]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkBackGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct ContentView: View {
    var body = DeckListView()
}

#Preview {
    ContentView()
}
