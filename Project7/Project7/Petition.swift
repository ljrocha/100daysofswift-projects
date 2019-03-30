//
//  Petition.swift
//  Project7
//
//  Created by Leandro Rocha on 3/29/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
