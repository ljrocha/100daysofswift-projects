//
//  ViewController.swift
//  MilestoneProjects19-21
//
//  Created by Leandro Rocha on 5/14/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var notes = [Note]()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let longAgoDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    let recentDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.toolbar.tintColor = UIColor(red: 190/255, green: 160/255, blue: 90/255, alpha: 1)
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
        let labelButtonItem = UIBarButtonItem(customView: countLabel)
        toolbarItems = [spacer, labelButtonItem, spacer, compose]
        navigationController?.isToolbarHidden = false
        
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load notes.")
            }
        }
        
        updateCountLabel()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        
        let dateString: String
        if note.date.timeIntervalSinceNow < -600 {
            dateString = longAgoDateFormatter.string(from: note.date)
        } else {
            dateString = recentDateFormatter.string(from: note.date)
        }
        cell.detailTextLabel?.text = "\(dateString) \(note.subtitle)"
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.noteToEdit = notes[indexPath.row]
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            save()
            updateCountLabel()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func composeTapped() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }
    
    func updateCountLabel() {
        if notes.count > 0 {
            countLabel.text = "\(notes.count) Notes"
        } else {
            countLabel.text = "Empty"
        }
    }
}

extension ViewController: DetailViewControllerDelegate {
    func detailViewController(_ vc: DetailViewController, didFinishEditing note: Note) {
        save()
        tableView.reloadData()
    }
    
    func detailViewController(_ vc: DetailViewController, didFinishAdding note: Note) {
        notes.insert(note, at: 0)
        save()
        updateCountLabel()
        tableView.reloadData()
    }
    
    func detailViewController(_ vc: DetailViewController, didFinishDeleting note: Note) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            notes.remove(at: selectedIndexPath.row)
            updateCountLabel()
            tableView.deleteRows(at: [selectedIndexPath], with: .automatic)
        }
    }
}
