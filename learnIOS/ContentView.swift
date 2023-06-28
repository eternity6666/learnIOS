//
//  ContentView.swift
//  learnIOS
//
//  Created by eternity6666 on 2023/6/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let emojisGroups: [[String]] = [
        Array(0...0xD7FF).compactMap { UnicodeScalar($0) }.map { String($0) },
        Array(0xE000...0x10FFFF).compactMap { UnicodeScalar($0) }.map { String($0) },
        Array(0x1F30D...0x1F567).compactMap { UnicodeScalar($0) }.map { String($0) },
        Array(0x1F469...0x1F9B0).compactMap { UnicodeScalar($0) }.map { String($0) },
        Array(0x1F004...0x1F5A5).compactMap { UnicodeScalar($0) }.map { String($0) },
    ]
    
    let emojiList = Array(0xE000...0x10FFFF).compactMap { UnicodeScalar($0) }.map { String($0) }
    
    let columns = [GridItem(.adaptive(minimum: 20))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(emojiList, id: \.self) { emoji in
                    Text(emoji)
                }
            }
            .padding()
        }
    }
    
    func emojiSelected(_ emoji: String) {
        // Handle the selected emoji here
        var result = ""
        for scalar in emoji.unicodeScalars {
            result = result + String(format: "%X", scalar.value)
        }
        print("Selected emoji: \(emoji) \(result)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
