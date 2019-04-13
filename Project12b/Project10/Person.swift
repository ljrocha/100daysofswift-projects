//
//  Person.swift
//  Project10
//
//  Created by Leandro Rocha on 4/8/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
