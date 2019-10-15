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
    private lazy var game = Concentraton()
    
    private var emojiChoices:String?
    private var theme:Theme?
    private var emoji = [Card:String]()
    private var themeList = [Theme]()
    
    
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var themeLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGame() {
        let randomIndex = themeList.count.arc4random()
        theme = themeList[randomIndex]
        view.backgroundColor = theme!.backgroundColor
        emojiChoices = theme!.emojiChoices
        game = Concentraton(numberOfPairsOfCards: (cardButtons.count+1)/2)
        emoji = [Card:String]()
        themeLabel.text = "Theme: \(theme!.themeName)"
        updataViewFromModel()
        
    }
    
    @IBAction private func touchButton(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updataViewFromModel()
            
        } else{
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    private func updataViewFromModel() {
        updateFlipCountLabel()
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
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil,emojiChoices!.count>0 {
            let randomStringIndex = emojiChoices!.index(emojiChoices!.startIndex, offsetBy: emojiChoices!.count.arc4random())
            emoji[card] = String(emojiChoices!.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func themeInit() {
        let animalTheme = Theme(themeName: "Animal", backgroundColor: .orange, cardBackColor: .red, emojiChoices: "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮")
        let sportTheme = Theme(themeName: "Sport", backgroundColor: .blue, cardBackColor: .green, emojiChoices: "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅🏒")
        let faceTheme = Theme(themeName: "Face", backgroundColor: .yellow, cardBackColor: .white, emojiChoices: "😀😃😄😁😆😅😂🤣☺️😊😇🙂")
        let carTheme = Theme(themeName: "Car", backgroundColor: .black, cardBackColor:.gray, emojiChoices: "🚗🚕🚙🚌🚎🏎🚓🚑🚒🚐🚚🚛")
        let flagTheme = Theme(themeName: "Flag", backgroundColor: .white, cardBackColor: .darkGray, emojiChoices: "🇰🇷🇯🇵🏳️🏴🏁🚩🏳️‍🌈🇱🇷🎌🇨🇦🇳🇵🇬🇪")
        let fruitTheme = Theme(themeName: "Fruit", backgroundColor: .green, cardBackColor: .yellow, emojiChoices: "🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑")
        themeList+=[animalTheme,sportTheme,faceTheme,carTheme,flagTheme,fruitTheme]
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

