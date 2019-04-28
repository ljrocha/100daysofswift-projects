//
//  DetailViewController.swift
//  Project16
//
//  Created by Leandro Rocha on 4/27/19.
//  Copyright © 2019 Leandro Rocha. All rights reserved.
//

import WebKit
import UIKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var capital: Capital?
    
    let baseURL = "https://en.wikipedia.org/wiki/"
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let capital = capital, let city = capital.title {
            title = capital.title
            
            let url: URL
            if city == "Washington DC" {
                url = URL(string: baseURL + "Washington,_D.C.")!
            } else {
                url = URL(string: baseURL + city)!
            }
            
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }

    }

}
