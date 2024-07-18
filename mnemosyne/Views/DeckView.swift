//
//  CardsStackView.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 23.06.24.
//

import Foundation
import Observation
import SwiftUI

struct DeckView: View {
    @State var isAddCardPresented = false
    @State private var deckController: DeckController
    @Environment(\.modelContext) var modelContext
    private var deckModel: DeckModel
    
    init(deckModel: DeckModel) {
        self.deckModel = deckModel
        deckController = DeckController(cardModels: deckModel.cardModels)
    }
    
    var body: some View {
        ZStack {
            ForEach(deckController.cardViewInfos) { cardViewInfo in
                CardView(deckController: deckController, cardViewInfo: cardViewInfo)
                    .zIndex(cardViewInfo.zIndex)
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
            AddCardSheet(deckModel: deckModel, deckController: deckController)
        })
        .onAppear(perform: {
            deckController.reload()
        })
    }
}

struct AddCardSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var frontText = ""
    @State var backText = ""
    
    var deckModel: DeckModel
    var deckController: DeckController
    
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
                        deckController.addCardViewInfo(cardModel: cardModel)
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
