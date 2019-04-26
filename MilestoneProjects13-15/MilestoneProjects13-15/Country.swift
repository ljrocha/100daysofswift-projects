//
//  Country.swift
//  MilestoneProjects13-15
//
//  Created by Leandro Rocha on 4/25/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let capital: String
    let size: Int
    let estimatedPopulation: Int
    let currency: String
}
