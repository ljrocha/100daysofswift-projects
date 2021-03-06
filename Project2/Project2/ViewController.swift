//
//  ViewController.swift
//  Project2
//
//  Created by Leandro Rocha on 3/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    let maxNumberOfQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Score", style: .plain, target: self, action: #selector(showScore))
        
        registerLocal()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        navigationItem.prompt = "Score: \(score)"
        
        questionsAsked += 1
        guard questionsAsked <= maxNumberOfQuestions else {
            showFinalScore()
            return
        }
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        UIView.animate(withDuration: 0.5) {
            self.button1.transform = .identity
            self.button2.transform = .identity
            self.button3.transform = .identity
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    func showFinalScore() {
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        
        let defaults = UserDefaults.standard
        let hasPlayedBefore = defaults.bool(forKey: "PlayedBefore")
        let highestScore = defaults.integer(forKey: "HighScore")
        
        var title = "Congratulations!"
        if !hasPlayedBefore {
            defaults.set(score, forKey: "HighScore")
            defaults.set(true, forKey: "PlayedBefore")
        } else if score > highestScore {
            defaults.set(score, forKey: "HighScore")
            title += " You have a new high score!"
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current score", message: "\(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            if granted {
                print("Granted local notifications permission")
                self?.scheduleLocal()
            } else {
                print("Denied local notifications permission")
            }
        }
    }
    
    func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let highScore = UserDefaults.standard.integer(forKey: "HighScore")
        let content = UNMutableNotificationContent()
        content.title = "Can you beat your previous high score of \(highScore)?"
        content.body = "Test your knowledge of country flags while earning points!"
        content.categoryIdentifier = "return"
        content.sound = .default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let play = UNNotificationAction(identifier: "play", title: "Play!", options: .foreground)
        let category = UNNotificationCategory(identifier: "return", actions: [play], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default identifier")
        case "play":
            let ac = UIAlertController(title: "Welcome back!", message: "Can you set a new record?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes!", style: .default) { [weak self] _ in
                self?.scheduleLocal()
            })
            present(ac, animated: true)
        default:
            break
        }
    }
}

