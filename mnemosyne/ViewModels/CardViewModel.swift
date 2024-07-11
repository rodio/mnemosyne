//
//  CardViewModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 10.07.24.
//

import Foundation
import DequeModule

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
    public var cardViewModels: Deque<CardViewModel> = []
    
    init(cardModels: [CardModel]) {
        for (offset, cardModel) in cardModels.enumerated() {
            cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: false, zIndex: Double(offset)))
        }
        if !cardViewModels.isEmpty {
            cardViewModels[cardViewModels.endIndex-1].isFront = true
        }
    }
    
    public func removeCardViewModel() {
        let _ = cardViewModels.popLast();
        guard let newLast = cardViewModels.popLast() else { return }
        newLast.isFront = true
        cardViewModels.append(newLast)
    }
    
    public func addCardViewModel(cardModel: CardModel) {
        for cardViewModel in cardViewModels {
            cardViewModel.isFront = false
        }
        
        cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: true, zIndex: Double(cardViewModels.endIndex+1)))
    }
}
