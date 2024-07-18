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
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.count == 0)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 0)
    }
    
    func testWorksWithOneCard() throws {
        let cardModels = createCardModels(n: 1)
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.count == 1)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 0)
    }
    
    func testWorksWithNoMoreCards() throws {
        let cardModels = createCardModels(n: 5)
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.count == 5)
        controller.removeCardViewInfo()
        controller.removeCardViewInfo()
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 2)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 1)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 0)
    }

    func testCreatesOnlyFive() throws {
        let cardModels = createCardModels(n: 6)
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.count == 5)
    }
    
    func testAddsWhenTwoLeft() throws {
        let cardModels = createCardModels(n: 10)
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.count == 5)
        
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 4)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 3)
        controller.removeCardViewInfo()
        assert(controller.cardViewInfos.count == 5)
    }
    
    func testRemovesCorrectly() throws {
        let cardModels = createCardModels(n: 5)
        let controller = CardViewInfoController(cardModels: cardModels)
        assert(controller.cardViewInfos.last!.isFront)
        let toBeRemovedId = controller.cardViewInfos.last!.id
        
        controller.removeCardViewInfo()
        assert(!controller.cardViewInfos.contains(where: {vm in vm.id == toBeRemovedId}))
        assert(controller.cardViewInfos.last!.id != toBeRemovedId)
        assert(controller.cardViewInfos.last!.isFront)
    }

    func testAddWhenMaxReached() throws {
        let cardModels = createCardModels(n: 5)
        let controller = CardViewInfoController(cardModels: cardModels)
        let toBeUnloadedId = controller.cardViewInfos.first!.id
        let cardModel = CardModel(frontText: "6", backText: "6")
        controller.addCardViewInfo(cardModel: cardModel)
        assert(controller.cardViewInfos.count == 5)
        assert(!controller.cardViewInfos.contains(where: {vm in vm.id == toBeUnloadedId}))
    }
}
