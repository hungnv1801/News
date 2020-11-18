//
//  WebViewController.swift
//  NEWS
//
//  Created by Nguyen Trung on 17/11/2020.
//  Copyright © 2020 Nguyen Hung. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var link: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  myURL = URL(string: link)
        let  myRequest =  URLRequest(url: myURL!)
        webView.load(myRequest)
        print(myURL)
    }
    
    
}
