//
//  ViewController.swift
//  MilestoneProjects4-6
//
//  Created by Leandro Rocha on 3/28/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemTapped))
        
        let removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeAllTapped))
        toolbarItems = [removeButton]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func removeAllTapped() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func addItemTapped() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text, !text.isEmpty else { return }
            self?.submit(text)
        }))
        present(ac, animated: true)
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let item = "Checkout my shopping list:\n" + list
        let vc = UIActivityViewController(activityItems: [item], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(vc, animated: true)
    }
    
    func submit(_ text: String) {
        let indexPath = IndexPath(row: shoppingList.count, section: 0)
        shoppingList.append(text)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }


}

