//
//  Theme.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import Foundation
import UIKit
class Theme{
    var themeName:String
    var backgroundColor:UIColor
    var cardBackColor:UIColor
    var emojiChoices:[String]
    
    init(themeName:String,backgroundColor:UIColor,cardBackColor:UIColor,emojiChoices:[String]) {
        self.themeName = themeName
        self.backgroundColor = backgroundColor
        self.cardBackColor = cardBackColor
        self.emojiChoices = emojiChoices
    }
    
}
