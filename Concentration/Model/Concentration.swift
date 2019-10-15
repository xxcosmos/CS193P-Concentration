//
//  Concentration.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

class Concentraton {
    
    // Card 结构体数组
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    
    // MARK：Optional 可选 computed 计算属性
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)):chosen index not in the cards")
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
            if cards[matchIndex].identifier == cards[index].identifier{
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
