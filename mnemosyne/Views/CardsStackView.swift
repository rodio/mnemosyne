//
//  CardsStackView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import Observation
import SwiftUI

class CurrentCardTracker {
    public var cardViewModels: [CardViewModel] = []
    private var deckModel: DeckModel

    init(deckModel: DeckModel) {
        self.deckModel = deckModel
        for (offset, cardModel) in deckModel.cards.enumerated() {
            var blur = 10.0
            if offset == deckModel.cards.endIndex-1 {
                blur = 0.0
            }
            cardViewModels.append(CardViewModel.init(cardModel: cardModel, blur: blur))
        }
    }

    public func removeCard(cardViewModel: CardViewModel) {
        guard let idx = cardViewModels.firstIndex(where: { $0.cardModel.id == cardViewModel.cardModel.id }) else { return }
        cardViewModels.remove(at: idx)
        if !cardViewModels.isEmpty {
            cardViewModels[cardViewModels.endIndex-1].blur = 0.0
        }
    }
}

@Observable
class CardViewModel : Identifiable {
    public var cardModel: CardModel
    public var blur: CGFloat
    public var id: UUID
    
    init(cardModel: CardModel, blur: CGFloat) {
        self.cardModel = cardModel
        self.blur = blur
        self.id = cardModel.id
    }
}

struct CardsStackView: View {
    private var currentCardTracker: CurrentCardTracker

    init(deckModel: DeckModel) {
        currentCardTracker = CurrentCardTracker(deckModel: deckModel)
    }

    var body: some View {
        ZStack {
            ForEach(currentCardTracker.cardViewModels) { cardViewModel in
                CardView(currentCardTracker: currentCardTracker, cardViewModel: cardViewModel)
            }
        }
    }
}
