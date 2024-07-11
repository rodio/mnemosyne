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

@Observable
class CardViewModelManager {
    public var cardViewModels: Deque<CardViewModel> = []
    
    private var cardModels: Deque<CardModel> = []
    private let maxCards = 5
    private let minCards = 2

    init(cardModels: [CardModel]) {
        for (offset, cardModel) in cardModels.enumerated() {
            if cardViewModels.count < maxCards {
                cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: false, zIndex: Double(offset)))
                continue
            }
            
            self.cardModels.append(cardModel)
        }
        if !cardViewModels.isEmpty {
            cardViewModels.last!.isFront = true
        }
    }
    
    public func removeCardViewModel() {
        let _ = cardViewModels.popLast();
        if cardViewModels.last != nil {
            cardViewModels.last!.isFront = true
        }
        
        if cardViewModels.count <= minCards {
            while cardViewModels.count < maxCards && cardModels.count != 0 {
                let zIdx = cardViewModels.first?.zIndex ?? 0.0
                cardViewModels.prepend(CardViewModel(cardModel: cardModels.popLast()!, isFront: false, zIndex: zIdx))
            }
        }
    }
    
    public func addCardViewModel(cardModel: CardModel) {
        for cardViewModel in cardViewModels {
            cardViewModel.isFront = false
        }
        
        cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: true, zIndex: Double(cardViewModels.endIndex+1)))
    }
}
