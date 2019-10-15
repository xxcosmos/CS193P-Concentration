//
//  Concentration.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

struct Concentraton {
    
    // Card 结构体数组
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    
    // MARK：Optional 可选 computed 计算属性
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            return cards.indices.filter{cards[$0].isFaceUp==true}.oneAndOnly
        }
        
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "(at:\(index)):chosen index not in the cards")
        // 当前选择的牌已经匹配
        if cards[index].isMatched{
            return
        }
        
        if let matchIndex = indexOfOneAndOnlyFaceUpCard{
            // 翻的是第二张牌
            if matchIndex == index{
                // 两次点击的是同一张牌
                return
            }
            flipCount+=1
            cards[index].isFaceUp = true
            if cards[matchIndex] == cards[index]{
                score+=2
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }else{
                if cards[index].isSeenBefore{
                    score-=1
                }
                if cards[matchIndex].isSeenBefore{
                    score -= 1
                }
                cards[index].isSeenBefore = true
                cards[matchIndex].isSeenBefore = true
            }
            
        }else{
            // 翻的是第一张牌
            flipCount+=1
            indexOfOneAndOnlyFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCards:Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        
        //MARK: Shuffle the cards
        for _ in 1...500{
            let randomIndex = cards.count.arc4random()
            cards.append(cards.remove(at: randomIndex))
        }
    }
    
    init() {
    }
    
}
