//
//  EmojiManager.swift
//  learnIOS
//
//  Created by eternity6666 on 2023/6/29.
//

import Foundation
import UIKit

class EmojiManager {
    static let shared = EmojiManager()
    
    var emojiList: [EmojiGroup] = []
    
    init() {
        if let asset = NSDataAsset(name: "emoji") {
            let data = asset.data
            let result = try? JSONDecoder().decode([EmojiGroup].self, from: data)
            emojiList = result ?? []
        }
    }
}

struct EmojiGroup: Codable, Hashable {
    let groupName: String
    let subgroupList: [EmojiSubgroup]
}

struct EmojiSubgroup: Codable, Hashable {
    let groupName: String
    let emojiList: [Emoji]
}

struct Emoji: Codable, Hashable {
    let emojiList: [String]
    let typeName: String
    let emoji: String
    let version: String
    let description: String
}
