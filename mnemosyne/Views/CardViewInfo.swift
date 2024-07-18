//
//  CardViewInfo.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 18.07.24.
//

import Foundation

@Observable
class CardViewInfo : Identifiable {
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
