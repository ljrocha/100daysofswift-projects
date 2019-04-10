//
//  ViewController.swift
//  Project1
//
//  Created by Leandro Rocha on 3/12/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadImages), with: nil)
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
        
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else {
            fatalError("Failed to dequeue StormCell")
        }
        
        let storm = pictures[indexPath.item]
        cell.imageView.image = UIImage(named: storm)
        cell.stormLabel.text = storm
        
        cell.imageView.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        cell.imageView.layer.borderWidth = 1
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            
            vc.selectedPictureNumber = indexPath.item + 1
            vc.totalPictures = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let items: [Any] = ["You should checkout this app!", URL(string: "https://www.apple.com")!]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

