//
//  ViewController.swift
//  Project18
//
//  Created by BERAT ALTUNTAŞ on 7.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I'm inside the viewDidLoad() method" ,terminator: "")
        print(1,2,3,4,5, separator: "\n")
        
        assert(1==1, "Math Failure!")
        assert(1==2, "Math Failure!")
    }


}

