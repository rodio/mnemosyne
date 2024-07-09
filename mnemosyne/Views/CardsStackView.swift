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
            var isFront = false
            if offset == deckModel.cards.endIndex-1 {
                isFront = true
            }
            cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: isFront))
        }
    }

    public func removeCard(cardViewModel: CardViewModel) {
        guard let idx = cardViewModels.firstIndex(where: { $0.cardModel.id == cardViewModel.cardModel.id }) else { return }
        cardViewModels.remove(at: idx)
        if !cardViewModels.isEmpty {
            cardViewModels[cardViewModels.endIndex-1].isFront = true
        }
    }
}

@Observable
class CardViewModel : Identifiable {
    public var cardModel: CardModel
    public var isFront: Bool
    public var id: UUID
    
    init(cardModel: CardModel, isFront: Bool) {
        self.cardModel = cardModel
        self.isFront = isFront
        self.id = cardModel.id
    }
}

struct CardsStackView: View {
    @State var isAddCardPresented = false
    private var currentCardTracker: CurrentCardTracker
    private var deckModel: DeckModel

    init(deckModel: DeckModel) {
        currentCardTracker = CurrentCardTracker(deckModel: deckModel)
        self.deckModel = deckModel
    }

    var body: some View {
        ZStack {
            ForEach(currentCardTracker.cardViewModels) { cardViewModel in
                CardView(currentCardTracker: currentCardTracker, cardViewModel: cardViewModel)
                    .zIndex(cardViewModel.isFront ? 1 : 0)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            Button(action: {
                isAddCardPresented = true
            }, label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $isAddCardPresented, content: {
            AddCardSheet(deckModel: deckModel)
        })
    }
}

struct AddCardSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State var frontText = ""
    @State var backText = ""
    
    var deckModel: DeckModel

    var body: some View {
        NavigationStack {
            Form {
                TextField("Front Text", text: $frontText)
                TextField("Back Text", text: $backText)
            }
            .navigationTitle("New Card")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        deckModel.cards.append(CardModel(frontText: frontText, backText: backText))
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
