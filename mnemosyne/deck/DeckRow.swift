import SwiftUI

struct DeckRow: View {
    var deck: Deck

    var body: some View {
        HStack {
            Text(deck.name)
                .font(.headline)
        }.padding(.all, 40)
    }
}

#Preview {
    Group {
        DeckRow(deck: decks[0])
        DeckRow(deck: decks[1])
        DeckRow(deck: decks[2])
    }
}
