//
//  WebViewController.swift
//  xColorPicker
//
//  Created by Alex Lundquist on 5/29/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var websites = ["en.wikipedia.org/wiki/RGB_color_model","en.wikipedia.org/wiki/HSL_and_HSV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func closeButton() {
        dismiss(animated: true, completion: nil)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host{
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}
