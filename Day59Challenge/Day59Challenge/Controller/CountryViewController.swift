//
//  CountryViewController.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelCountryName: UILabel!
    
    var country = [Country]()
    var listOfTableViewSeen = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        let imageUrl = country[0].flags.png
        let countryName = country[0].name
        let nativeName = country[0].nativeName
        labelCountryName?.text = countryName + " - " + nativeName
        let url = URL(string: imageUrl)
        downloadImage(from: url!)
        getClassAttiributes()
    }
    func getClassAttiributes(){
        guard let capital = country[0].capital else {return}
        guard let area = country[0].area else{return}
        guard let currenciesCode = country[0].currencies?[0].code else{return}
        guard let currenciesName = country[0].currencies?[0].name else{return}
        guard let currenciesSymbol = country[0].currencies?[0].symbol else{return}
        
        listOfTableViewSeen.append("Capital: " + capital)
        listOfTableViewSeen.append("Region: " + country[0].region.rawValue)
        listOfTableViewSeen.append("Subregion: " + country[0].subregion)
        listOfTableViewSeen.append("Population: " + String(country[0].population))
        
        listOfTableViewSeen.append("Area: "+String(area))
        listOfTableViewSeen.append("Timezone: " + country[0].timezones[0])
        
        listOfTableViewSeen.append("Currency Code: " + String(currenciesCode))
        listOfTableViewSeen.append("Currency Name: "+String(currenciesName))
        listOfTableViewSeen.append("Currency Symbol: " + String(currenciesSymbol))
        
        listOfTableViewSeen.append("Is Independent: " + String(country[0].independent))
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
   
                                           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTableViewSeen.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = listOfTableViewSeen[indexPath.row]
        return cell
    }
    		
}
