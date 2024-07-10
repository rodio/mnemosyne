//
//  CardsStackView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import Observation
import SwiftUI

struct CardsStackView: View {
    @State var isAddCardPresented = false
    @State private var cardViewModelManager: CardViewModelManager
    private var deckModel: DeckModel
    
    init(deckModel: DeckModel) {
        cardViewModelManager = CardViewModelManager(cardModels: deckModel.cardModels)
        self.deckModel = deckModel
    }
    
    var body: some View {
        ZStack {
            ForEach(cardViewModelManager.cardViewModels) { cardViewModel in
                CardView(cardViewModelManager: cardViewModelManager, cardViewModel: cardViewModel)
                    .zIndex(cardViewModel.zIndex)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .toolbar {
            Button(action: {
                isAddCardPresented = true
            }, label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $isAddCardPresented, content: {
            AddCardSheet(deckModel: deckModel, cardViewModelManager: cardViewModelManager)
        })
    }
}

struct AddCardSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State var frontText = ""
    @State var backText = ""
    
    var deckModel: DeckModel
    var cardViewModelManager: CardViewModelManager
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Front Text", text: $frontText)
                TextField("Back Text", text: $backText)
            }
            .navigationTitle("New Card")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let cardModel = CardModel(frontText: frontText, backText: backText)
                        deckModel.addCardModel(cardModel: cardModel)
                        cardViewModelManager.addCardViewModel(cardModel: cardModel)
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
