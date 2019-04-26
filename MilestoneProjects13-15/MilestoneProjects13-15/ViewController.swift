//
//  ViewController.swift
//  MilestoneProjects13-15
//
//  Created by Leandro Rocha on 4/25/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadCountries()
    }
    
    func loadCountries() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            if let url = Bundle.main.url(forResource: "Countries", withExtension: "json") {
                if let data = try? Data(contentsOf: url) {
                    let decoder = JSONDecoder()
                    
                    if let countries = try? decoder.decode([Country].self, from: data) {
                        self.countries = countries
                    }
                }
            }
            
            self.countries.sort { $0.name < $1.name }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.country = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

