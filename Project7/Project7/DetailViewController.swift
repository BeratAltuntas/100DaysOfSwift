//
//  DetailViewController.swift
//  Project7
//
//  Created by BERAT ALTUNTAŞ on 6.02.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var selectedPetition: Petition?
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedPetition = selectedPetition else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size:150%; } </style>
        </head>
        <body>\(selectedPetition.body)</body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }

}
