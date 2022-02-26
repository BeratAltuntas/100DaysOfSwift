//
//  ViewController.swift
//  Project12
//
//  Created by BERAT ALTUNTAŞ on 26.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "age")
        defaults.set(true, forKey: "UseFaceId")
        defaults.set(CGFloat.pi, forKey: "pi")
        
        defaults.set("Berat Altuntas", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello" , "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["name":"Berat","Country":"TR"]
        defaults.set(dict, forKey: "SavedDictionary")
        
        let savedInteger = defaults.integer(forKey: "age")
        let savedBoolean = defaults.bool(forKey: "UseFaceId")
        
        let savedArray = defaults.object(forKey: "SavedArray") ?? [String]()
        
        let savedDictionary = defaults.dictionary(forKey: "SavedDictionary") ?? [String: Any]()
        
        
        
    }


}

