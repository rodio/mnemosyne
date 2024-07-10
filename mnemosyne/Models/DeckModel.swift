//
//  DeckModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 22.06.24.
//

import Foundation
import SwiftData

@Model
class DeckModel {
    init(name: String, cards: [CardModel]) {
        self.name = name
        self.cardModels = cards
    }
    
    public var name: String
    @Relationship(deleteRule: .cascade)
    public var cardModels: [CardModel]
    
    public func addCardModel(cardModel: CardModel) {
        cardModels.append(cardModel)
    }
}
