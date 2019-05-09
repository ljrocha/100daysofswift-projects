//
//  UserScriptsViewController.swift
//  Extension
//
//  Created by Leandro Rocha on 5/8/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

protocol ScriptPickerViewControllerDelegate: class {
    func scriptPicker(_ controller: ScriptPickerViewController, didPick script: JSCode)
}

class ScriptPickerViewController: UITableViewController {
    
    var userScripts: [JSCode]!
    
    weak var delegate: ScriptPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userScripts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserScript", for: indexPath)
        cell.textLabel?.text = userScripts[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let script = userScripts[indexPath.row]
            delegate.scriptPicker(self, didPick: script)
        }
    }

}
