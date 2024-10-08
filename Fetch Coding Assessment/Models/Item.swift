//
//  Item.swift
//  Fetch Coding Assessment
//
//  Created by Rudra Amin on 10/8/24.
//

import Foundation

struct Item: Codable, Hashable {
    var id: Int
    var listId: Int
    var name: String?
}
