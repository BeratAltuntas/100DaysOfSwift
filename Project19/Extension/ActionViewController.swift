//
//  ActionViewController.swift
//  Extension
//
//  Created by BERAT ALTUNTAŞ on 12.03.2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {

    var pageTitle = ""
    var pageURL = ""
    @IBOutlet var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showQuickScripts))
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let  inputItem = extensionContext?.inputItems.first as? NSExtensionItem{
            if let itemProvider = inputItem.attachments?.first{
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String){
                    [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else{return}
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else{return}
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }
    @objc func adjustForKeyboard(notification: Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{return}
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, to: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            textView.contentInset = .zero
        }else{
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height-view.safeAreaInsets.bottom, right: 0)
        }
        textView.scrollIndicatorInsets = textView.contentInset
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
                                                
        
    }
    
    @objc func showQuickScripts(){
        let ac = UIAlertController(title: "Quick Prepared Scripts", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Show Document Title", style: .default, handler: scripts))
        ac.addAction(UIAlertAction(title: "Show Document Url", style: .default, handler: scripts))
        ac.addAction(UIAlertAction(title: "Show Date", style: .default, handler: scripts))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    func scripts(action:UIAlertAction){
        guard let actionTitle = action.title else{return}
        switch actionTitle{
        case "Show Document Title":
            textView.text = """
alert(document.title);
"""
            break
        case "Show Document Url":
            textView.text = """
alert(document.URL);
"""
            break
        case "Show Date":
            textView.text = """
const d = new Date();
var year = d.getFullYear();
var month = d.getMonth();
var day = d.getDate();
alert((day)+" "+month+" "+year);
"""
            break
        default:
            break
        }
        done()
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary  = ["customJavaScript": textView.text]
        let webDictionary : NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey:argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext!.completeRequest(returningItems: [item])
    }

}
