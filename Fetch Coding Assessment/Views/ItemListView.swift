//
//  ItemListView.swift
//  Fetch Coding Assessment
//
//  Created by Rudra Amin on 10/8/24.
//

import SwiftUI

struct ItemListView: View {
    @ObservedObject var vm = ItemViewModel()
    
    var body: some View {
        List {
            ForEach(vm.items, id: \.self) { group in
                //Create a section for every groupId
                Section(header: Text("List ID: \(group.first?.listId ?? 0)")) {
                    ForEach(group, id: \.id) { item in
                        Text(item.name ?? "")
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await vm.loadItems()
                } catch {
                    print("Error fetching data: \(error)")
                }
            }
        }
    }
}

#Preview {
    ItemListView()
}
