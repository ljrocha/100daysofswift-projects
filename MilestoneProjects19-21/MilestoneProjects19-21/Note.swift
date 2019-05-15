//
//  Note.swift
//  MilestoneProjects19-21
//
//  Created by Leandro Rocha on 5/14/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import Foundation

class Note: Codable {
    var text: String
    var date = Date()
    
    var title: String {
        if let index = text.firstIndex(of: "\n") {
            let title = text.prefix(upTo: index)
            return String(title)
        }
        return text.count > 0 ? text : "New Note"
    }
    
    var subtitle: String {
        if let index = text.firstIndex(of: "\n") {
            let newStartIndex = text.index(after: index)
            let newText = text.suffix(from: newStartIndex)
            return newText.count > 0 ? String(newText) : "No additional text"
        }
        return "No additional text"
    }
    
    
    
    init(text: String) {
        self.text = text
    }

}
