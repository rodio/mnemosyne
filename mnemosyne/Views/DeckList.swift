import SwiftData
import SwiftUI

struct DeckList: View {
    @Environment(\.colorScheme) var colorScheme

    @Query var deckModels: [DeckModel]

    var body: some View {
        NavigationSplitView {
            List(deckModels, id: \.id) { deckModel in
                NavigationLink {
                    CardsStack(deckModel: deckModel)
                } label: {
                    DeckRow(deckModel: deckModel)
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
