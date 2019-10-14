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
