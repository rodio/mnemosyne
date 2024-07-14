//
//  CardModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 22.06.24.
//

import Foundation
import SwiftData

@Model
class CardModel : Comparable {
    static func < (lhs: CardModel, rhs: CardModel) -> Bool {
        return lhs.nextShow < rhs.nextShow
    }
    
    init(frontText: String, backText: String) {
        self.frontText = frontText
        self.backText = backText
        id = UUID()
        nextShow = Date.now
    }

    public var frontText: String
    public var backText: String
    public var id: UUID
    public var nextShow: Date
}
