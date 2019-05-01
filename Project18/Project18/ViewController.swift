//
//  ViewController.swift
//  Project18
//
//  Created by Leandro Rocha on 5/1/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("I'm inside the viewDidLoad() method!")
        
        print(1, 2, 3, 4, 5)
        
        print(1, 2, 3, 4, 5, separator: "-")
        
        print("Some message", terminator: "")
        
        assert(1 == 1, "Math failure!")
//        assert(1 == 2, "Math failure!")
        
        for i in 1...100 {
            print("Got number \(i)")
        }

    }


}

