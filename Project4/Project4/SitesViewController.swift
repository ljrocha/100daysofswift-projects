//
//  SitesViewController.swift
//  Project4
//
//  Created by Leandro Rocha on 3/22/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class SitesViewController: UITableViewController {

    var websites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let startWebsitesURL = Bundle.main.url(forResource: "websites", withExtension: "txt") {
            if let startWebsites = try? String(contentsOf: startWebsitesURL) {
                let trimmedStartWebsites = startWebsites.trimmingCharacters(in: .whitespacesAndNewlines)
                websites = trimmedStartWebsites.components(separatedBy: "\n")
            }
        }
        
        if websites.isEmpty {
            websites = ["swiftbysundell.com"]
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.websites = websites
            vc.websiteSelected = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
