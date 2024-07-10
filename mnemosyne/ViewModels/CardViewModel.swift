//
//  CardViewModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 10.07.24.
//

import Foundation

@Observable
class CardViewModel : Identifiable {
    public var cardModel: CardModel
    public var isFront: Bool
    public var id: UUID
    public var zIndex: Double
    
    init(cardModel: CardModel, isFront: Bool, zIndex: Double) {
        self.cardModel = cardModel
        self.isFront = isFront
        self.id = cardModel.id
        self.zIndex = zIndex
    }
}

class CardViewModelManager {
    public var cardViewModels: [CardViewModel] = []
    
    init(cardModels: [CardModel]) {
        for (offset, cardModel) in cardModels.enumerated() {
            cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: false, zIndex: Double(offset)))
        }
        if !cardViewModels.isEmpty {
            cardViewModels[cardViewModels.endIndex-1].isFront = true
        }
    }
    
    public func removeCardViewModel(cardViewModel: CardViewModel) {
        guard let idx = cardViewModels.firstIndex(where: { $0.cardModel.id == cardViewModel.cardModel.id }) else { return }
        cardViewModels.remove(at: idx)
        if !cardViewModels.isEmpty {
            print("front is now \(cardViewModels[cardViewModels.endIndex-1].cardModel.frontText)")
            cardViewModels[cardViewModels.endIndex-1].isFront = true
        }
    }
    
    public func addCardViewModel(cardModel: CardModel) {
        for cardViewModel in cardViewModels {
            cardViewModel.isFront = false
        }
        
        cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: true, zIndex: Double(cardViewModels.endIndex+1)))
    }
}
