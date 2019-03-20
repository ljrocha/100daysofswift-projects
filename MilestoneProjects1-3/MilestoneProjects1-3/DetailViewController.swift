//
//  DetailViewController.swift
//  MilestoneProjects1-3
//
//  Created by Leandro Rocha on 3/19/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedCountry: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let country = selectedCountry {
            title = country.count > 3 ? country.capitalized : country.uppercased()
            imageView.image = UIImage(named: country)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let countryName = selectedCountry else {
            print("No country was selected")
            return
        }
        
        let country = countryName.count > 3 ? countryName.capitalized : countryName.uppercased()
        let items: [Any] = [image, country]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
