//
//  CommonUtil.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation

// 工具类
class CommonUtil{
    class func getRandomInt(in number:Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
}

extension Int{
    func arc4random() -> Int {
        if self == 0{
            return 0
        }
        if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        
        return Int(arc4random_uniform((UInt32(self))))
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
