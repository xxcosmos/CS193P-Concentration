//
//  ViewController.swift
//  Concentration
//
//  Created by 张啸宇 on 2019/10/14.
//  Copyright © 2019年 张啸宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // important lazy
    lazy var game = Concentraton()
    
    var emojiChoices = [String]()
    var theme:Theme?
    var emoji = [Int:String]()
    var themeList = [Theme]()
 

    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame() {
        let randomIndex = CommonUtil.getRandomInt(in: themeList.count)
        theme = themeList[randomIndex]
        view.backgroundColor = theme!.backgroundColor
        emojiChoices = theme!.emojiChoices
        game = Concentraton(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emoji = [Int:String]()
        themeLabel.text = "Theme: \(theme!.themeName)"
        updataViewFromModel()
        
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updataViewFromModel()
            
        } else{
            print("chosen card was not in cardButtons")
        }
    }
    
    func updataViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isMatched{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0)
                continue
            }
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: .normal)
                button.backgroundColor =  theme!.cardBackColor
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,emojiChoices.count>0 {
            let randomIndex = CommonUtil.getRandomInt(in: emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    func themeInit() {
        let animalTheme = Theme(themeName: "Animal", backgroundColor: .orange, cardBackColor: .red, emojiChoices: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"])
        let sportTheme = Theme(themeName: "Sport", backgroundColor: .blue, cardBackColor: .green, emojiChoices: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"])
        let faceTheme = Theme(themeName: "Face", backgroundColor: .yellow, cardBackColor: .white, emojiChoices: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"])
        let carTheme = Theme(themeName: "Car", backgroundColor: .black, cardBackColor:.gray, emojiChoices: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"])
        let flagTheme = Theme(themeName: "Flag", backgroundColor: .white, cardBackColor: .darkGray, emojiChoices: ["🇰🇷", "🇯🇵", "🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇱🇷", "🎌", "🇨🇦", "🇳🇵", "🇬🇪"])
        let fruitTheme = Theme(themeName: "Fruit", backgroundColor: .green, cardBackColor: .yellow, emojiChoices: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"])
        themeList.append(fruitTheme)
        themeList.append(flagTheme)
        themeList.append(carTheme)
        themeList.append(faceTheme)
        themeList.append(sportTheme)
        themeList.append(animalTheme)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeInit()
        
        newGame()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

