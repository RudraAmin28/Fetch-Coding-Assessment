//
//  ItemViewModel.swift
//  Fetch Coding Assessment
//
//  Created by Rudra Amin on 10/8/24.
//

import Foundation

class ItemViewModel: ObservableObject {
    // list of items grouped by their listId
    @Published var items: [[Item]] = []
    
    // Loads item data from using an HTTP request and updates items variable
    func loadItems() async throws {
        guard let url = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        do {
            let decodedData = try JSONDecoder().decode([Item].self, from: data)
            items = filterItems(decodedData)
            
            
        } catch {
            throw error
        }
    }
    
    // Removes invalid names, then sorts by listId and then name. Finally the method groups the items by listId
    private func filterItems(_ items: [Item]) -> [[Item]] {
        let filteredItems = items.filter { item in
            guard let name = item.name, !name.isEmpty else { return false }
            return true
        }
        
        let sortedItems = filteredItems.sorted {
            if $0.listId == $1.listId {
                return $0.name! < $1.name!
            }
            return $0.listId < $1.listId
        }
        
        let groupedItems = Dictionary(grouping: sortedItems) { $0.listId }
        
        return groupedItems.values.sorted { $0[0].listId < $1[0].listId }
    }


    
    
}
