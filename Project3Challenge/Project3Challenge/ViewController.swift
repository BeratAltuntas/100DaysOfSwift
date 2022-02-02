//
//  ViewController.swift
//  Project3Challenge
//
//  Created by BERAT ALTUNTAŞ on 29.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    var flags=[String]()
    var row:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm=FileManager.default
        let path=Bundle.main.resourcePath!
        let items=try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasSuffix("2x.png")
            {
                flags.append(item)
            }
        }
        print(flags)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text=flags[indexPath.row]
        row=indexPath.row
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController
        {
            vc.selectedFlag = flags[indexPath.row]
            vc.selectedFlagsCountry = String(flags[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


