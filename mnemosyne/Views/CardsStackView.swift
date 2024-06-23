//
//  CardsStack.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import SwiftUI

struct CardsStackView: View {
    public var deckModel: DeckModel

    var body: some View {
        ZStack {
            ForEach(deckModel.cards) { card in
                CardView(cardModel: card)
            }
        }
    }
}
