import SwiftUI

struct DeckList: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationSplitView {
            List(decks, id: \.id) { deck in
                NavigationLink {
                    Card()
                } label: {
                    DeckRow(deck: deck)
                }
                .listRowBackground(colorScheme == .light ? lightBackgroundGradient : darkBackgroundGradient)
            }
            .navigationTitle("Decks")
            .listRowSpacing(20.0)
            // .background(colorScheme == .light ? lightBackgroundGradient : darkBackgroundGradient)
            .scrollContentBackground(.hidden)
            .listStyle(.sidebar)
        }
        detail: {
            Text("Select a deck")
        }
    }
}

#Preview() {
    DeckList()
}
