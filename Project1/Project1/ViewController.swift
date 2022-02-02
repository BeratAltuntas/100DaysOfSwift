//
//  ViewController.swift
//  Project1
//
//  Created by BERAT ALTUNTAŞ on 25.01.2022.
//

import UIKit

class ViewController: UITableViewController {
    var pictures=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Görseller"
        navigationController?.navigationBar.prefersLargeTitles=true
        let fm=FileManager.default
        let path=Bundle.main.resourcePath!
        let items=try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasPrefix("nssl")
            {
                pictures.append(item)
            }
        }
        print(pictures)
        OrderBy()
        print(pictures)
    }
    
    func OrderBy(){
        
        
        var i=0
        var j=i
        while  i<pictures.count{
            
            while j<i{
                
                let startI = pictures[i].index(pictures[i].startIndex, offsetBy: 6)
                let endI = pictures[i].index(pictures[i].endIndex, offsetBy: -4)
                let rangeI = startI..<endI

                let numberI = Int(pictures[i][rangeI]) ?? 0 
                
                
                let startJ = pictures[j].index(pictures[j].startIndex, offsetBy: 6)
                let endJ = pictures[j].index(pictures[j].endIndex, offsetBy: -4)
                let rangeJ = startJ..<endJ

                let numberJ = Int(pictures[j][rangeJ]) ?? 0
                
                
                if numberI < numberJ{
                    let con = pictures[i]
                    pictures[i]=pictures[j]
                    pictures[j]=con
                }
                j+=1
                
            }
            j=0
            i+=1
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pictures.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text=pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc=storyboard?.instantiateViewController(withIdentifier: "Detail")as? DetailVieViewController
        {
            vc.selectedImage=pictures[indexPath.row]
            vc.selectedImgIndex=String(indexPath.row+1)
            vc.imageCount=String(pictures.count)
            navigationController?.pushViewController(vc, animated: true)
        }	
    }
}

