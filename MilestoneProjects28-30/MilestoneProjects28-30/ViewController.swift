//
//  ViewController.swift
//  MilestoneProjects28-30
//
//  Created by Leandro Rocha on 6/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardButtons = [UIButton]()
    var capitalCities = [String: String]()
    
    var buttonTitles = [String]()
    
    var selectedCardButton: UIButton?
    var pairsFound = 0 {
        didSet {
            if pairsFound >= cardButtons.count / 2 {
                showMessage()
            }
        }
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            buttonsView.widthAnchor.constraint(equalToConstant: 690),
            buttonsView.heightAnchor.constraint(equalToConstant: 890),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
                
                let cardButton = UIButton(type: .system)
                cardButton.layer.cornerRadius = 4
                cardButton.layer.borderWidth = 1
                cardButton.layer.borderColor = UIColor.lightGray.cgColor
                cardButton.setTitleColor(.white, for: .normal)
                
                cardButton.addTarget(self, action: #selector(cardTapped(_:)), for: .touchUpInside)
                
                let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)
                cardButton.frame = frame
                
                buttonsView.addSubview(cardButton)
                cardButtons.append(cardButton)
            }
            
            xOffset = 0
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
        
        buttonTitles = Array(capitalCities.keys)
        buttonTitles.append(contentsOf: (Array(capitalCities.values)))
        
        startNewGame()
    }

    @objc func cardTapped(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }
        
        sender.setTitleColor(.lightGray, for: .normal)
        
        if let selectedCardButton = selectedCardButton {
            guard let selectedCardTitle = selectedCardButton.currentTitle else { return }
            
            view.isUserInteractionEnabled = false
            
            if cardsMatch(selectedCardTitle, senderTitle) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.pairsFound += 1
                    selectedCardButton.isHidden = true
                    sender.isHidden = true
                    self.view.isUserInteractionEnabled = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    selectedCardButton.setTitleColor(.white, for: .normal)
                    sender.setTitleColor(.white, for: .normal)
                    self.view.isUserInteractionEnabled = true
                }
            }
            
            self.selectedCardButton = nil
        } else {
            selectedCardButton = sender
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
    
    func showMessage() {
        let ac = UIAlertController(title: "Congratulations!", message: "You found all the pairs!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again!", style: .default) { [weak self] _ in
            self?.startNewGame()
        })
        present(ac, animated: true)
    }
    
    func startNewGame() {
        buttonTitles.shuffle()
        pairsFound = 0
        
        for i in 0 ..< cardButtons.count {
            cardButtons[i].setTitle(buttonTitles[i], for: .normal)
            cardButtons[i].setTitleColor(.white, for: .normal)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.cardButtons.forEach { $0.isHidden = false }
        }
    }
}

