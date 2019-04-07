//
//  ViewController.swift
//  MilestoneProjects7-9
//
//  Created by Leandro Rocha on 4/6/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var attemptsLeftLabel: UILabel!
    var targetWordLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var words = [String]()
    var targetWord = ""
    var usedLetters = [String]()
    var displayWord: String {
        var str = ""
        for letter in targetWord {
            let strLetter = String(letter)
            if usedLetters.contains(strLetter) {
                str += strLetter
            } else {
                str += "?"
            }
        }
        return str
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score == targetWord.count {
                showSuccessAlert()
            }
        }
    }
    var numberOfAttempts = 0 {
        didSet {
            attemptsLeftLabel.text = "Attempts left: \(maxNumberOfAttempts - numberOfAttempts)"
            if numberOfAttempts >= maxNumberOfAttempts {
                showMaxTriesAlert()
            }
        }
    }
    let maxNumberOfAttempts = 7
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        attemptsLeftLabel = UILabel()
        attemptsLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsLeftLabel.textAlignment = .right
        attemptsLeftLabel.textColor = .red
        attemptsLeftLabel.text = "Attempts left: 7"
        view.addSubview(attemptsLeftLabel)
        
        targetWordLabel = UILabel()
        targetWordLabel.translatesAutoresizingMaskIntoConstraints = false
        targetWordLabel.font = UIFont.systemFont(ofSize: 30)
        targetWordLabel.numberOfLines = 0
        targetWordLabel.textAlignment = .center
        targetWordLabel.text = "Word to guess"
        targetWordLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(targetWordLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            
            attemptsLeftLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            attemptsLeftLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            
            targetWordLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 50),
            targetWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 560),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: targetWordLabel.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50)
            ])
        
        let width = 80
        let height = 80
        let maxLetterButtons = 26
        var letterButtonsAdded = 0
        
        outerloop: for row in 0..<4 {
            for column in 0..<7 {
                if letterButtonsAdded < maxLetterButtons {
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                    let letter = String(Unicode.Scalar(65 + letterButtonsAdded)!)
                    letterButton.setTitle(letter, for: .normal)
                    
                    letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                    
                    let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                    letterButton.frame = frame
                    
                    buttonsView.addSubview(letterButton)
                    letterButtons.append(letterButton)
                    
                    letterButtonsAdded += 1
                } else {
                    break outerloop
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        words += ["HELLO", "WORLD", "APPLE", "SWIFT", "XCODE", "IPHONE", "XBOX"]
        
        startNewGame()
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonLetter = sender.titleLabel?.text else {
            return
        }
        
        usedLetters.append(buttonLetter)
        sender.isHidden = true
        
        guard targetWord.contains(buttonLetter) else {
            numberOfAttempts += 1
            return
        }
        
        score += targetWord.reduce(0) { total, letter in
            if letter == Character(buttonLetter) {
                return total + 1
            }
            
            return total
        }
        
        targetWordLabel.text = displayWord
    }
    
    func showSuccessAlert() {
        let ac = UIAlertController(title: "Excellent", message: "You guessed it!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: startNewGame))
        present(ac, animated: true)
    }
    
    func showMaxTriesAlert() {
        let ac = UIAlertController(title: "Maximum attempts", message: "You've exceeded the maximum allowed attempts", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: startNewGame))
        present(ac, animated: true)
    }
    
    func startNewGame(action: UIAlertAction! = nil) {
        targetWord = words.randomElement()!
        score = 0
        numberOfAttempts = 0
        
        usedLetters.removeAll()
        targetWordLabel.text = displayWord
        
        for button in letterButtons {
            button.isHidden = false
        }
    }

}

