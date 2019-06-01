//
//  ViewController.swift
//  MilestoneProjects25-27
//
//  Created by Leandro Rocha on 5/31/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

enum TextPlacement {
    case top
    case bottom
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    var shareButtonItem: UIBarButtonItem!
    var topTextButtonItem: UIBarButtonItem!
    var bottomTextButtonItem: UIBarButtonItem!
    
    var originalImage: UIImage?
    var topText: String?
    var bottomText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Meme Generator"
        navigationController?.hidesBarsOnTap = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPhoto))
        shareButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        shareButtonItem.isEnabled = false
        navigationItem.rightBarButtonItem = shareButtonItem
        
        topTextButtonItem = UIBarButtonItem(title: "Set Top Text", style: .plain, target: self, action: #selector(addTopText))
        topTextButtonItem.isEnabled = false
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        bottomTextButtonItem = UIBarButtonItem(title: "Set Bottom Text", style: .plain, target: self, action: #selector(addBottomText))
        bottomTextButtonItem.isEnabled = false
        toolbarItems = [topTextButtonItem, spacer, bottomTextButtonItem]
        navigationController?.isToolbarHidden = false
    }
    
    @objc func importPhoto() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        imageView.image = image
        originalImage = image
        shareButtonItem.isEnabled = true
        topTextButtonItem.isEnabled = true
        bottomTextButtonItem.isEnabled = true
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func addTopText() {
        addText(to: .top)
    }
    
    @objc func addBottomText() {
        addText(to: .bottom)
    }
    
    func addText(to placement: TextPlacement) {
        guard originalImage != nil else { return }
        
        let ac = UIAlertController(title: "Enter text...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            switch placement {
            case .top:
                self?.topText = text
            case .bottom:
                self?.bottomText = text
            }
            self?.renderMeme()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func renderMeme() {
        guard let image = originalImage else { return }
        
        let imageSize = image.size
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        
        let memeImage = renderer.image { ctx in
            image.draw(at: .zero)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 40),
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
            
            if let topText = topText {
                let attributedString = NSAttributedString(string: topText, attributes: attrs)
                let rect = CGRect(x: imageSize.width / 4, y: 0, width: imageSize.width / 2, height: imageSize.height / 2)
                attributedString.draw(in: rect)
            }
            
            if let bottomText = bottomText {
                let attributedString = NSAttributedString(string: bottomText, attributes: attrs)
                let rect = CGRect(x: imageSize.width / 4, y: (imageSize.height / 4) * 3, width: imageSize.width / 2, height: imageSize.height / 4)
                attributedString.draw(in: rect)
            }
        }
        
        imageView.image = memeImage
    }

}

