//
//  ViewController.swift
//  MilestoneProjects28-30
//
//  Created by Leandro Rocha on 6/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cards = [UIButton]()
    
    var capitalCities = [String: String]()
    var cardTitles = [String]()
    
    var previousCard: UIButton?
    
    var cardPairsFound = 0 {
        didSet {
            if cardPairsFound >= cards.count / 2 {
                displayAllPairsFoundAlert()
            }
        }
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let cardButtonsView = UIView()
        cardButtonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardButtonsView)
        
        NSLayoutConstraint.activate([
            cardButtonsView.widthAnchor.constraint(equalToConstant: 690),
            cardButtonsView.heightAnchor.constraint(equalToConstant: 890),
            cardButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardButtonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        let width = 165
        let height = 215
        let space = 10
        var xOffset = 0
        var yOffset = 0
        
        for row in 0..<4 {
            yOffset = row * (height + space)
            
            for column in 0..<4 {
                xOffset = column * (width + space)
                
                let card = UIButton(type: .system)
                card.layer.cornerRadius = 4
                card.backgroundColor = .darkGray
                card.addTarget(self, action: #selector(backCardTapped(_:)), for: .touchUpInside)
                
                let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
                card.frame = frame
                
                cardButtonsView.addSubview(card)
                cards.append(card)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        capitalCities = [
            "United States": "Washington, D.C.",
            "Canada": "Ottawa",
            "Mexico": "Mexico City",
            "Belgium": "Brussels",
            "Argentina": "Buenos Aires",
            "Venezuela": "Caracas",
            "Ireland": "Dublin",
            "Spain": "Madrid"
        ]
        
        cardTitles = Array(capitalCities.keys) + Array(capitalCities.values)
        
        startNewGame()
    }

    @objc func backCardTapped(_ sender: UIButton) {
        flipCard(sender)
        
        if let previousCard = previousCard {
            guard let previousCardTitle = previousCard.currentTitle else { return }
            guard let currentCardTitle = sender.currentTitle else { return }

            view.isUserInteractionEnabled = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                if self.cardsMatch(previousCardTitle, currentCardTitle) {
                    self.cardPairsFound += 1

                    previousCard.isHidden = true
                    sender.isHidden = true
                } else {
                    self.flipCard(previousCard, makeVisible: false)
                    self.flipCard(sender, makeVisible: false)
                }

                self.view.isUserInteractionEnabled = true
                self.previousCard = nil
            }
        } else {
            previousCard = sender
        }
    }
    
    func cardsMatch(_ card1: String, _ card2: String) -> Bool {
        if let capital = capitalCities[card1], capital == card2 {
            return true
        } else if let capital = capitalCities[card2], capital == card1 {
            return true
        }
        
        return false
    }
    
    func displayAllPairsFoundAlert() {
        let ac = UIAlertController(title: "Congratulations!", message: "You found all the pairs!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again!", style: .default) { [weak self] _ in
            self?.startNewGame()
        })
        present(ac, animated: true)
    }
    
    func startNewGame() {
        cardTitles.shuffle()
        cardPairsFound = 0
        
        self.cards.forEach {
            $0.isHidden = false
            
            $0.setTitle(nil, for: .normal)
            $0.backgroundColor = .darkGray
            $0.isUserInteractionEnabled = true
        }
    }
    
    func flipCard(_ card: UIButton, makeVisible: Bool = true) {
        let transitionOptions: UIView.AnimationOptions
        if makeVisible {
            transitionOptions = [.transitionFlipFromLeft]
        } else {
            transitionOptions = [.transitionFlipFromRight]
        }
        
        UIView.transition(with: card, duration: 0.75, options: transitionOptions, animations: {
            if makeVisible {
                if let cardIndex = self.cards.firstIndex(of: card) {
                    let cardTitle = self.cardTitles[cardIndex]
                    
                    card.setTitle(cardTitle, for: .normal)
                    card.backgroundColor = .lightGray
                    card.isUserInteractionEnabled = false
                }
            } else {
                card.setTitle(nil, for: .normal)
                card.backgroundColor = .darkGray
                card.isUserInteractionEnabled = true
            }
        })
    }
}

