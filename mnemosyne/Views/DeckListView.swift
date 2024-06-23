import SwiftData
import SwiftUI

struct DeckListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Query var deckModels: [DeckModel]

    var body: some View {
        NavigationSplitView {
            List(deckModels) { deckModel in
                NavigationLink {
                    CardsStackView(deckModel: deckModel)
                } label: {
                    Text(deckModel.name)
                        .font(.headline)
                        .padding(.all, 20)
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
    DeckListView()
}
