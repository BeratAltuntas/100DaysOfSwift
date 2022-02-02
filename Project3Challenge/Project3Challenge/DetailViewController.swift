//
//  DetailViewController.swift
//  Project3Challenge
//
//  Created by BERAT ALTUNTAŞ on 29.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedFlag:String?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    var selectedFlagsCountry:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ShareFlag))
        
        if let flagToLoad=selectedFlag{
            imageView.image=UIImage(named:flagToLoad)
            
        }
        imageView.layer.borderWidth=2
        
        var array = selectedFlagsCountry!.split(separator: "@", maxSplits: 3, omittingEmptySubsequences: false)
        selectedFlagsCountry!=String(array[0])
        label.text = selectedFlagsCountry!.uppercased()
        
        array.removeAll()
    }
    
    @objc func ShareFlag(){
        let vc = UIActivityViewController(activityItems: [selectedFlagsCountry!.uppercased()], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem=navigationItem.rightBarButtonItem
        present(vc, animated:true)
    }
    

}
