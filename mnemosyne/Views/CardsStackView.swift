//
//  CardsStackView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import SwiftUI

class CurrentCardTracker: ObservableObject {
    @Published var visibleCardId: UUID
    public var deckModel: DeckModel
    private var visibleCardIdx: Int

    init(deckModel: DeckModel) {
        self.deckModel = deckModel
        visibleCardIdx = 0
        visibleCardId = deckModel.cards[visibleCardIdx].id
    }

    public func nextCard() {
        visibleCardIdx += 1
        if visibleCardIdx >= deckModel.cards.count {
            visibleCardIdx = 0
        }
        visibleCardId = deckModel.cards[visibleCardIdx].id
    }
}

struct CardsStackView: View {
    @StateObject private var currentCardTracker: CurrentCardTracker

    init(deckModel: DeckModel) {
        _currentCardTracker = StateObject(wrappedValue: CurrentCardTracker(deckModel: deckModel))
    }

    var body: some View {
        ZStack {
            ForEach(currentCardTracker.deckModel.cards) { card in
                CardView(cardModel: card, currentCardTracker: currentCardTracker)
                    .opacity(card.id == currentCardTracker.visibleCardId ? .infinity : 0.0)
            }
        }
    }
}
