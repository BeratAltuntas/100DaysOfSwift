//
//  ViewController.swift
//  Project4
//
//  Created by BERAT ALTUNTAŞ on 30.01.2022.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {
    var webView:WKWebView!
    var progressView:UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com", "tureng.com"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title="Websites"
        navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(ButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let backward = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(barButtonSystemItem:.fastForward, target: webView, action: #selector(webView.goForward))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        navigationController?.isToolbarHidden = true
        
        toolbarItems=[spacer, backward, progressButton, forward, spacer, refresh]
        
        
//        let url = URL(string: "https://"+websites[0])!
//        webView.load(URLRequest(url: url))
//        webView.allowsBackForwardNavigationGestures=true
        
        
    }
    
    @objc func ButtonTapped(){
        let ac=UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .default, handler: OpenPage))
        }
        ac.addAction(UIAlertAction(title: "obisis.kayseri.edu.tr", style: .default, handler: OpenPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: OpenPage))
        ac.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(ac, animated:true)
    }
    
    
    func OpenPage(action:UIAlertAction){
        var bool=false
        for website in websites{
            if action.title == website{
                bool=true
            }
        }
        if !bool && action.title != "Cancel"{
            let blockedPop = UIAlertController(title: "Blocked", message: "This site is blocked.", preferredStyle: .alert)
            blockedPop.addAction(UIAlertAction(title: "Okay", style: .cancel ))
            present(blockedPop, animated: true)
        }
        if action.title == "Cancel"{
            loadView()
            title="Websites"
            navigationController?.isToolbarHidden = true
        }
        guard let actionTitle = action.title else{ return}
        guard let url = URL(string:"https://"+actionTitle) else{return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures=true
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host{
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        webView = WKWebView()
        webView.navigationDelegate = self
        
        view = webView
        navigationController?.isToolbarHidden=false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let url = URL(string: "https://" + websites[indexPath.row])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures=true
    }
}

