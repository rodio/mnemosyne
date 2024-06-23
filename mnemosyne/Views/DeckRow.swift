import SwiftUI

struct DeckRow: View {
    var deckModel: DeckModel

    var body: some View {
        HStack {
            Text(deckModel.name)
                .font(.headline)
        }.padding(.all, 20)
    }
}

#Preview {
    Group {
        DeckRow(
            deckModel: DeckModel(
                name: "Demo Deck",
                cards: [CardModel(frontText: "Demo Deck, Card 1, Front", backText: "Demo Deck, Card 1, Back")]
            ))
    }
}
