//
//  DetailViewController.swift
//  MilestoneProjects13-15
//
//  Created by Leandro Rocha on 4/25/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    
    var country: Country?
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let country = country {
            title = country.name
            
            capitalLabel.text = country.capital
            
            let size: Measurement<UnitArea> = Measurement(value: Double(country.size), unit: .squareKilometers)
            sizeLabel.text = numberFormatter.string(from: NSNumber(value: size.value))! + " \(size.unit.symbol)"
            
            populationLabel.text = numberFormatter.string(from: NSNumber(value: country.estimatedPopulation))! + " million"
            currencyLabel.text = country.currency
        }

    }

    @objc func shareTapped() {
        guard let country = country else { return }
        
        let population = numberFormatter.string(from: NSNumber(value: country.estimatedPopulation))!
        let message = "Did you know the population of \(country.name) is estimated to be \(population) million?"
        
        let ac = UIActivityViewController(activityItems: [message], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}
