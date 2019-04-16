//
//  DetailViewController.swift
//  MilestoneProjects10-12
//
//  Created by Leandro Rocha on 4/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let photo = photo {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let path = paths[0].appendingPathComponent(photo.filename)
            
            imageView.image = UIImage(contentsOfFile: path.path)
            captionLabel.text = photo.caption
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

}
