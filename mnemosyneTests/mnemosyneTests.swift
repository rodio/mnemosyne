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
    
    func testRemovesCorrectly() throws {
        let cardModels = createCardModels(n: 5)
        let manager = CardViewModelManager(cardModels: cardModels)
        assert(manager.cardViewModels.last!.isFront)
        let toBeRemovedId = manager.cardViewModels.last!.id
        
        manager.removeCardViewModel()
        assert(!manager.cardViewModels.contains(where: {vm in vm.id == toBeRemovedId}))
        assert(manager.cardViewModels.last!.id != toBeRemovedId)
        assert(manager.cardViewModels.last!.isFront)
    }

    func testAddWhenMaxReached() throws {
        let cardModels = createCardModels(n: 5)
        let manager = CardViewModelManager(cardModels: cardModels)
        let toBeUnloadedId = manager.cardViewModels.first!.id
        let cardModel = CardModel(frontText: "6", backText: "6")
        manager.addCardViewModel(cardModel: cardModel)
        assert(manager.cardViewModels.count == 5)
        assert(!manager.cardViewModels.contains(where: {vm in vm.id == toBeUnloadedId}))
    }
}
