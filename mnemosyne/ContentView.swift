//
//  ContentView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftUI

let lightGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.mint]), startPoint: .topLeading, endPoint: .bottomTrailing)

let lightBackGradient = LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.mint]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.orange]), startPoint: .bottomTrailing, endPoint: .topLeading)

let darkBackGradient = LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)

struct ContentView: View {
    var body = DeckListView()
}

#Preview {
    ContentView()
}
