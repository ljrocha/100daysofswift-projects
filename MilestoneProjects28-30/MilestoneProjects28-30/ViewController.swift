//
//  ViewController.swift
//  MilestoneProjects28-30
//
//  Created by Leandro Rocha on 6/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backCards = [UIButton]()
    var frontCards = [UIButton]()
    
    var capitalCities = [String: String]()
    var frontCardTitles = [String]()
    
    var previousFrontCard: UIButton?
    
    var cardPairsFound = 0 {
        didSet {
            if cardPairsFound >= frontCards.count / 2 {
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
                
                let frontCard = UIButton(type: .system)
                frontCard.layer.cornerRadius = 4
                frontCard.backgroundColor = .lightGray
                frontCard.isUserInteractionEnabled = false
                frontCard.isHidden = true
                
                let backCard = UIButton(type: .system)
                backCard.layer.cornerRadius = 4
                backCard.backgroundColor = .darkGray
                backCard.addTarget(self, action: #selector(backCardTapped(_:)), for: .touchUpInside)
                
                let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
                frontCard.frame = frame
                backCard.frame = frame
                
                cardButtonsView.addSubview(frontCard)
                cardButtonsView.addSubview(backCard)
                
                frontCards.append(frontCard)
                backCards.append(backCard)
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
        
        frontCardTitles = Array(capitalCities.keys)
        frontCardTitles.append(contentsOf: Array(capitalCities.values))
        
        startNewGame()
    }

    @objc func backCardTapped(_ sender: UIButton) {
        guard let senderIndex = backCards.firstIndex(of: sender) else { return }

        let currentFrontCard = frontCards[senderIndex]
        
        flipCard(currentFrontCard, underCard: sender)
        
        if let previousFrontCard = previousFrontCard {
            guard let previousFrontCardTitle = previousFrontCard.currentTitle else { return }
            guard let currentFrontCardTitle = currentFrontCard.currentTitle else { return }
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                
                if self.cardsMatch(previousFrontCardTitle, currentFrontCardTitle) {
                    self.cardPairsFound += 1
                    
                    UIView.animate(withDuration: 1.0) {
                        previousFrontCard.isHidden = true
                        currentFrontCard.isHidden = true
                    }
                } else {
                    guard let previousFrontCardIndex = self.frontCards.firstIndex(of: previousFrontCard) else { return }
                    let previousBackCard = self.backCards[previousFrontCardIndex]
                    
                    self.flipCard(previousFrontCard, underCard: previousBackCard, makeVisible: false)
                    self.flipCard(currentFrontCard, underCard: sender, makeVisible: false)
                }
                
                self.view.isUserInteractionEnabled = true
                self.previousFrontCard = nil
            }
        } else {
            previousFrontCard = currentFrontCard
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
        frontCardTitles.shuffle()
        cardPairsFound = 0
        
        for i in 0 ..< frontCards.count {
            frontCards[i].setTitle(frontCardTitles[i], for: .normal)
        }
        
        self.frontCards.forEach { $0.isHidden = true }
        self.backCards.forEach { $0.isHidden = false}
    }
    
    func flipCard(_ frontCard: UIButton, underCard backCard: UIButton, makeVisible: Bool = true) {
        let transitionOptions: UIView.AnimationOptions
        if makeVisible {
            transitionOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        } else {
            transitionOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        }
        
        UIView.transition(with: backCard, duration: 1.0, options: transitionOptions, animations: {
            if makeVisible {
                backCard.isHidden = true
            } else {
                backCard.isHidden = false
            }
        })
        
        UIView.transition(with: frontCard, duration: 1.0, options: transitionOptions, animations: {
            if makeVisible {
                frontCard.isHidden = false
            } else {
                frontCard.isHidden = true
            }
        })
    }
}

