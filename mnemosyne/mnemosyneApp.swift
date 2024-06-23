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
                DeckModel(name: "Test", cards: [CardModel(frontText: "Front", backText: "Back")]),
            ]

            for item in items {
                container.mainContext.insert(item)
            }

            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [DeckModel.self])
        }
    }
}
