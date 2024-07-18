import SwiftData
import SwiftUI

struct DeckListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Query var deckModels: [DeckModel]
    @State var isAddDeckSheetPresented = false

    var body: some View {
        NavigationSplitView {
            List(deckModels) { deckModel in
                NavigationLink {
                    DeckView(deckModel: deckModel)
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
            .sheet(isPresented: $isAddDeckSheetPresented) {
                AddDeckSheet()
            }

            Spacer()

            Button("Add Deck") {
                isAddDeckSheetPresented = true
            }
        }
        detail: {
            Text("Select a deck")
        }
        .accentColor(colorScheme == .light ? .black : .white)
    }
}

struct AddDeckSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context

    @State private var deckName: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Deck Name", text: $deckName)
            }
            .navigationTitle("New Deck")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let deck = DeckModel(name: deckName, cards: [CardModel(frontText: "Front", backText: "Back")])
                        context.insert(deck)
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
