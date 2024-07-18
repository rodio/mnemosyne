//
//  DeckController.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 10.07.24.
//

import Foundation
import DequeModule
import HeapModule
import SwiftData

@Observable
class DeckController {
    var cardViewInfos: Deque<CardViewInfo> = []
    var offloadedViewDatas: [CardViewInfo] = []

    private var cardModels: Heap<CardModel>
    private let maxCards = 5
    private let minCards = 2

    init(cardModels: [CardModel]) {
        self.cardModels = Heap(cardModels)
        reload()
    }
    
    public func reload() {
        defer {
            for cardViewInfo in cardViewInfos {
                cardViewInfo.isFront = false
            }
            if !cardViewInfos.isEmpty {
                cardViewInfos.last!.isFront = true
            }
        }
        
        if cardViewInfos.count <= maxCards && cardViewInfos.count > minCards {
            return
        }
        
        if cardViewInfos.count > maxCards {
            print("offloading")
            while cardViewInfos.count > maxCards {
                self.offloadedViewDatas.append(cardViewInfos.popFirst()!)
            }
            return
        }
        
        // cardViewInfos.count > minCards:
        for cardViewInfo in offloadedViewDatas {
            cardViewInfos.prepend(cardViewInfo)
            if cardViewInfos.count >= maxCards {
                break
            }
        }
        
        while cardViewInfos.count < maxCards {
            if cardModels.count == 0 {
                return
            }
            if cardModels.min!.nextShow > Date.now {
                return
            }
            let zIdx = cardViewInfos.first?.zIndex ?? 0.0
            cardViewInfos.prepend(CardViewInfo(cardModel: cardModels.popMin()!, isFront: false, zIndex: zIdx))
        }
    }
    
    public func removeCardViewInfo() {
        let removed = cardViewInfos.popLast();
        if removed != nil {
            removed!.cardModel.nextShow = Date.now.addingTimeInterval(30)
        }
        if cardViewInfos.last != nil {
            cardViewInfos.last!.isFront = true
        }
        reload()
    }
    
    public func addCardViewInfo(cardModel: CardModel) {
        cardViewInfos.append(CardViewInfo.init(cardModel: cardModel, isFront: true, zIndex: Double(cardViewInfos.endIndex+1)))
        reload()
    }
}
