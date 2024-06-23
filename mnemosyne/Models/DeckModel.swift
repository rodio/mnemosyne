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
        self.cards = cards
    }

    public var name: String
    @Relationship(deleteRule: .cascade)
    public var cards: [CardModel]
}
