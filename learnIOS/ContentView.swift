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
    
    //    let emojiList = Array(0xE000...0x10FFFF).compactMap { UnicodeScalar($0) }.map { String($0) }
    
    let emojiGroupList = EmojiManager.shared.emojiList
    @State private var selectedGroupIndex = 0
    
    var body: some View {
        VStack {
            ScrollView {
                let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 10)
                let currentGroup = emojiGroupList[selectedGroupIndex]
                ForEach(currentGroup.subgroupList, id: \.self) { subList in
                    GroupBox {
                        let len = 10
                        let emojiListReduce = subList.emojiList.group(len)
                        ForEach(emojiListReduce, id: \.self) { emojiList in
                            HStack {
                                ForEach(emojiList, id: \.self) { emoji in
                                    Text(buildEmojiStr(emoji))
                                }
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: Alignment.leading)
                        }
                    } label: {
                        Text(subList.groupName)
                    }
                }
                .padding()
            }
            Picker("EmojiGroup", selection: $selectedGroupIndex) {
                ForEach(0 ..< emojiGroupList.count, id: \.self) { index in
                    Text(emojiGroupList[index].groupName)
                }
            }
            .pickerStyle(.menu)
            .padding(.horizontal, 16)
        }
    }
    
    private func buildEmojiStr(_ emoji: Emoji) -> String {
        var emojiString = ""
        emoji.emojiList.forEach { emojiItem in
            if let intValue = UInt32(emojiItem, radix: 16),  let scalar = UnicodeScalar(intValue) {
                emojiString += String(scalar)
            }
        }
        return emojiString
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

extension Array {
    func group(_ len: Int) -> [[Element]] {
        stride(from: 0, to: count, by: len).map {
            Array(self[$0..<Swift.min($0+len, count)])
        }
    }
}
