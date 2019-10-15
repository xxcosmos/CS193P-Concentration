//
//  Card.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var isSeenBefore = false
    var identifier: Int
    
    // 静态成员变量
    private static var identifierFactor = 0
    
    // 静态方法
    private static func getUniqueIdentifier() -> Int{
        identifierFactor+=1
        return identifierFactor
    }
    
    // 构造函数 分配唯一ID
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
