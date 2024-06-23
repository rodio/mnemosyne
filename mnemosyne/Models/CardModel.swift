//
//  CardModel.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 22.06.24.
//

import Foundation
import SwiftData

@Model
class CardModel {
    init(frontText: String, backText: String) {
        self.frontText = frontText
        self.backText = backText
        id = UUID()
    }

    public var frontText: String
    public var backText: String
    public var id: UUID
}
