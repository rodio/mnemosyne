//
//  CardsStackView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import Observation
import SwiftUI

@Observable
class CurrentCardTracker: ObservableObject {
    public var cardModels: [CardModel]

    init(deckModel: DeckModel) {
        cardModels = deckModel.cards
    }

    public func removeCard(cardModel: CardModel) {
        guard let idx = cardModels.firstIndex(where: { $0.id == cardModel.id }) else { return }
        cardModels.remove(at: idx)
    }
}

struct CardsStackView: View {
    private var currentCardTracker: CurrentCardTracker

    init(deckModel: DeckModel) {
        currentCardTracker = CurrentCardTracker(deckModel: deckModel)
    }

    var body: some View {
        ZStack {
            ForEach(currentCardTracker.cardModels) { card in
                CardView(cardModel: card, currentCardTracker: currentCardTracker)
            }
        }
    }
}
