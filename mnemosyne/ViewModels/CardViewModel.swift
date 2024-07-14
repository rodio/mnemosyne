//
//  CardViewModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 10.07.24.
//

import Foundation
import DequeModule
import HeapModule

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
    public var offloadedCardViewModels: [CardViewModel] = []

    private var cardModels: Heap<CardModel>
    private let maxCards = 5
    private let minCards = 2

    init(cardModels: [CardModel]) {
        self.cardModels = Heap(cardModels)
        reload()
    }
    
    public func reload() {
        defer {
            for cardViewModel in cardViewModels {
                cardViewModel.isFront = false
            }
            if !cardViewModels.isEmpty {
                cardViewModels.last!.isFront = true
            }
        }
        
        if cardViewModels.count <= maxCards && cardViewModels.count > minCards {
            return
        }
        
        if cardViewModels.count > maxCards {
            print("offloading")
            while cardViewModels.count > maxCards {
                self.offloadedCardViewModels.append(cardViewModels.popFirst()!)
            }
            return
        }
        
        // cardViewModels.count > minCards:
        for cardViewModel in offloadedCardViewModels {
            cardViewModels.prepend(cardViewModel)
            if cardViewModels.count >= maxCards {
                break
            }
        }
        
        while cardViewModels.count < maxCards {
            if cardModels.count == 0 {
                return
            }
            if cardModels.min!.nextShow > Date.now {
                return
            }
            let zIdx = cardViewModels.first?.zIndex ?? 0.0
            cardViewModels.prepend(CardViewModel(cardModel: cardModels.popMin()!, isFront: false, zIndex: zIdx))
        }
    }
    
    public func removeCardViewModel() {
        let removed = cardViewModels.popLast();
        if removed != nil {
            removed!.cardModel.nextShow = Date.now.addingTimeInterval(30)
        }
        if cardViewModels.last != nil {
            cardViewModels.last!.isFront = true
        }
        reload()
    }
    
    public func addCardViewModel(cardModel: CardModel) {
        cardViewModels.append(CardViewModel.init(cardModel: cardModel, isFront: true, zIndex: Double(cardViewModels.endIndex+1)))
        reload()
    }
}
