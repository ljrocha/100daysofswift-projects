//
//  ActionViewController.swift
//  Extension
//
//  Created by Leandro Rocha on 5/5/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, ScriptPickerViewControllerDelegate {

    @IBOutlet var script: UITextView!

    var pageTitle = ""
    var pageURL = ""
    
    var userScripts = [JSCode]()
    let key = "userScripts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sample", style: .plain, target: self, action: #selector(sampleScripts))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let customButtonItem = UIBarButtonItem(title: "My Scripts", style: .plain, target: self, action: #selector(customScripts))
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveScript))
        toolbarItems = [customButtonItem, spacer, saveButtonItem]
        navigationController?.isToolbarHidden = false
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        // Load custom scripts
        let defaults = UserDefaults.standard
        if let savedScripts = defaults.object(forKey: key) as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                userScripts = try jsonDecoder.decode([JSCode].self, from: savedScripts)
            } catch {
                print("Failed to load custom scripts")
            }
        }
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }
    
    @objc func sampleScripts() {
        let ac = UIAlertController(title: "Select a prewritten script...", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Alert", style: .default) { [weak self] _ in
            self?.script.text = "alert(document.title);"
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func customScripts() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ScriptPicker") as? ScriptPickerViewController {
            vc.userScripts = userScripts
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func saveScript() {
        let ac = UIAlertController(title: "Type a name for the script...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let self = self else { return }
            guard let scriptName = ac?.textFields?[0].text else { return }
            
            let jsCode = JSCode(name: scriptName, script: self.script.text)
            self.userScripts.append(jsCode)
            
            let jsonEncoder = JSONEncoder()
            if let savedData = try? jsonEncoder.encode(self.userScripts) {
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: self.key)
            }
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    // MARK: - ScriptPickerViewControllerDelegate
    func scriptPicker(_ controller: ScriptPickerViewController, didPick script: JSCode) {
        self.script.text = script.script
        navigationController?.popViewController(animated: true)
    }

}
