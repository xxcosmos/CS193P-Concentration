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
    var cards = [Card]()
    var flipCount = 0
    var score = 0
    // Optional 可选
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
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
            indexOfOneAndOnlyFaceUpCard = nil
            
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
            for index in cards.indices{
                cards[index].isFaceUp = false
            }
            // 翻的是第一张牌
            flipCount+=1
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
            
            
        }
        
    }
    init(numberOfPairsOfCards:Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        
        //TODO: Shuffle the cards
        for _ in 1...500{
            let randomIndex = CommonUtil.getRandomInt(in: cards.count)
            cards.append(cards.remove(at: randomIndex))
            
        }
    }
    
    init() {
    }
    
}
