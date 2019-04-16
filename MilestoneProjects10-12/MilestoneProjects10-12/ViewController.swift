//
//  ViewController.swift
//  MilestoneProjects10-12
//
//  Created by Leandro Rocha on 4/15/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhotoTapped))
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let photo = pictures[indexPath.row]
        let path = getDocumentsDirectory().appendingPathComponent(photo.filename)
        cell.textLabel?.text = photo.caption
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Update caption", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        })
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let self = self else { return }
            guard let caption = ac?.textFields?[0].text else { return }
            
            self.pictures[indexPath.row].caption = caption
            self.save()
            self.tableView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.photo = pictures[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let photo = pictures[indexPath.row]
            let path = getDocumentsDirectory().appendingPathComponent(photo.filename)
            try? FileManager.default.removeItem(at: path)
            
            pictures.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @objc func addPhotoTapped() {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // MARK: - Image Picker Delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let filename = UUID().uuidString
        let path = getDocumentsDirectory().appendingPathComponent(filename)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: path)
        }
        
        let photo = Photo(filename: filename, caption: "No caption")
        pictures.append(photo)
        save()
        tableView.reloadData()
        
        dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Helper methods
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "pictures")
        } else {
            print("Failed to save pictures")
        }
    }
    
    @objc func loadPictures() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                pictures = try jsonDecoder.decode([Photo].self, from: savedData)
                tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
            } catch {
                print("Failed to load pictures")
            }
        }
    }

}

