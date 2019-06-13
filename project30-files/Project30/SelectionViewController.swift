//
//  SelectionViewController.swift
//  Project30
//
//  Created by TwoStraws on 20/08/2016.
//  Copyright (c) 2016 TwoStraws. All rights reserved.
//

import UIKit

class SelectionViewController: UITableViewController {
	var items = [String]() // this is the array that will store the filenames to load
    var images = [UIImage]()
	var dirty = false

    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Reactionist"

		tableView.rowHeight = 90
		tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

		// load all the JPEGs into our array
		let fm = FileManager.default

        if let resourcePath = Bundle.main.resourcePath {
            if let tempItems = try? fm.contentsOfDirectory(atPath: resourcePath) {
                for item in tempItems {
                    if item.range(of: "Large") != nil {
                        items.append(item)
                    }
                }
            }
        }
        
        loadImages()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if dirty {
			// we've been marked as needing a counter reload, so reload the whole table
			tableView.reloadData()
		}
	}
    
    func loadImages() {
        for image in items {
            let imageRootName = image.replacingOccurrences(of: "Large", with: "Thumb")
            
            guard let path = Bundle.main.path(forResource: imageRootName, ofType: nil) else {
                fatalError("Could not find path for image: \(imageRootName)")
            }
            
            guard let original = UIImage(contentsOfFile: path) else {
                fatalError("Could not load contents of file: \(path)")
            }
            
            let rendererRect = CGRect(origin: .zero, size: CGSize(width: 90, height: 90))
            let renderer = UIGraphicsImageRenderer(size: rendererRect.size)
            
            let rounded = renderer.image { ctx in
                //            ctx.cgContext.setShadow(offset: .zero, blur: 200, color: UIColor.black.cgColor)
                //            ctx.cgContext.fillEllipse(in: CGRect(origin: .zero, size: original.size))
                //            ctx.cgContext.setShadow(offset: .zero, blur: 0, color: nil)
                
                ctx.cgContext.addEllipse(in: rendererRect)
                ctx.cgContext.clip()
                
                original.draw(in: rendererRect)
            }
            images.append(rounded)
        }
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return images.count * 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		// find the image for this cell, and load its thumbnail
        let currentImage = items[indexPath.row % items.count]
        let rounded = images[indexPath.row % items.count]
        
        let rendererRect = CGRect(origin: .zero, size: CGSize(width: 90, height: 90))

		cell.imageView?.image = rounded

		// give the images a nice shadow to make them look a bit more dramatic
        cell.imageView?.layer.shadowColor = UIColor.black.cgColor
        cell.imageView?.layer.shadowOpacity = 1
        cell.imageView?.layer.shadowRadius = 10
        cell.imageView?.layer.shadowOffset = CGSize.zero
        cell.imageView?.layer.shadowPath = UIBezierPath(ovalIn: rendererRect).cgPath

		// each image stores how often it's been tapped
		let defaults = UserDefaults.standard
		cell.textLabel?.text = "\(defaults.integer(forKey: currentImage))"

		return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = ImageViewController()
		vc.image = items[indexPath.row % items.count]
        vc.loadedImage = images[indexPath.row % items.count]
		vc.owner = self

		// mark us as not needing a counter reload when we return
		dirty = false

		navigationController?.pushViewController(vc, animated: true)
	}
}
