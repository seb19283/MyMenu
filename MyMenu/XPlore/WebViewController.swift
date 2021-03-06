//
//  WebViewController.swift
//  MyMenu
//
//  Created by Isaac Rand (student LM) on 4/16/18.
//  Copyright © 2018 Sebastian Connelly (student LM). All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var websiteLink: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let URL = websiteLink {
            let myRequest = URLRequest(url: URL)
            webView.load(myRequest)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
    
}
