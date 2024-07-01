//
//  mnemosyneApp.swift
//  mnemosyne
//
//  Created by Rodion Borovyk on 05.06.24.
//

import SwiftData
import SwiftUI

@main
@MainActor
struct mnemosyneApp: App {
    let appContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: DeckModel.self)

            // Make sure the persistent store is empty. If it's not, return the non-empty container.
            var itemFetchDescriptor = FetchDescriptor<DeckModel>()
            itemFetchDescriptor.fetchLimit = 1

            guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return container }

            // This code will only run if the persistent store is empty.
            let items = [
                DeckModel(name: "Demo Deck",
                          cards: [CardModel(frontText: "Card 1 Front", backText: "Card 1 Back"),
                                  CardModel(frontText: "Card 2 Front", backText: "Card 2 Back"),
                                  CardModel(frontText: "Card 3 Front", backText: "Card 3 Back")]),
            ]

            for item in items {
                container.mainContext.insert(item)
            }

            return container
        } catch let error {
            fatalError("Failed to create container \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [DeckModel.self])
        }
    }
}
