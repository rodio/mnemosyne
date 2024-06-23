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
                .listRowBackground(colorScheme == .light ? lightGradient : darkGradient)
            }
            .navigationTitle("Decks")
            .padding(.top, 30)
            .listRowSpacing(30)
            .scrollContentBackground(.hidden)
        }
        detail: {
            Text("Select a deck")
        }
        .accentColor(colorScheme == .light ? .black : .white)
    }
}

#Preview() {
    DeckList()
}
