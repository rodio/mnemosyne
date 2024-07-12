//
//  mnemosyneTests.swift
//  mnemosyneTests
//
//  Created by Rodion Borovyk on 05.06.24.
//

import XCTest
@testable import mnemosyne

final class mnemosyneTests: XCTestCase {
    
    func createCardModels(n: Int) -> [CardModel] {
        var cardModels : [CardModel] = []
        for i in 1...n {
            cardModels.append(CardModel(frontText: String(i), backText: String(i)))
        }
        return cardModels
    }
    
    func testWorksWithNoCards() throws {
        let cardModels : [CardModel] = []
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.count == 0)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 0)
    }
    
    func testWorksWithOneCard() throws {
        let cardModels = createCardModels(n: 1)
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.count == 1)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 0)
    }
    
    func testWorksWithNoMoreCards() throws {
        let cardModels = createCardModels(n: 5)
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.count == 5)
        manager.removeCardViewModel()
        manager.removeCardViewModel()
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 2)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 1)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 0)
    }

    func testCreatesOnlyFive() throws {
        let cardModels = createCardModels(n: 6)
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.count == 5)
    }
    
    func testAddsWhenTwoLeft() throws {
        let cardModels = createCardModels(n: 10)
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.count == 5)
        
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 4)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 3)
        manager.removeCardViewModel()
        assert(manager.cardViewModels.count == 5)
    }
}
