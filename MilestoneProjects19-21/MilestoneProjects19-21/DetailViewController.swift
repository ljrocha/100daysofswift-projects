//
//  DetailViewController.swift
//  MilestoneProjects19-21
//
//  Created by Leandro Rocha on 5/14/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewController(_ vc: DetailViewController, didFinishAdding note: Note)
    func detailViewController(_ vc: DetailViewController, didFinishEditing note: Note)
    func detailViewController(_ vc: DetailViewController, didFinishDeleting note: Note)
}

class DetailViewController: UIViewController {

    @IBOutlet var noteTextView: UITextView!
    
    var noteToEdit: Note?
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeTapped))
        toolbarItems = [delete, spacer, compose]
        
        noteTextView.delegate = self

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let note = noteToEdit {
            noteTextView.text = note.text
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            noteTextView.contentInset = .zero
        } else {
            noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        noteTextView.scrollIndicatorInsets = noteTextView.contentInset
        
        let selectedRange = noteTextView.selectedRange
        noteTextView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func shareTapped() {
        guard let note = noteToEdit else { return }
        
        let vc = UIActivityViewController(activityItems: [note.text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func deleteTapped() {
        guard let note = noteToEdit else { return }
        delegate?.detailViewController(self, didFinishDeleting: note)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func composeTapped() {
        noteTextView.text = ""
        noteToEdit = nil
        noteTextView.becomeFirstResponder()
    }

}

extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if let note = noteToEdit {
            note.text = noteTextView.text
            note.date = Date()
            delegate?.detailViewController(self, didFinishEditing: note)
        } else if noteTextView.text.count > 0 {
            let newNote = Note(text: noteTextView.text)
            delegate?.detailViewController(self, didFinishAdding: newNote)
        }
    }
}
