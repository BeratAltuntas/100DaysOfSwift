//
//  ViewController.swift
//  Project7
//
//  Created by BERAT ALTUNTAŞ on 5.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title goes here"
        cell.detailTextLabel?.text = "Subtitle gooes here"
        return cell
    }

}

