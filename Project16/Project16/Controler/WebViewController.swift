//
//  WebViewController.swift
//  Project16
//
//  Created by BERAT ALTUNTAŞ on 5.03.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: WKWebView!
    var capital = [Capital]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://en.wikipedia.org/wiki/" + capital[0].title!)
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures=true
    }
}
