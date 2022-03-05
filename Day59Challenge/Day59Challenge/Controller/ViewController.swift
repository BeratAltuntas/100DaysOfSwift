//
//  ViewController.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit


class ViewController: UITableViewController {
    var countries = [Country]()
    var tempCountries = [Country]()
    var filteredCountryArray = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterText))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getBackAllCountries))
        tempCountries = countries
        
        performSelector(onMainThread: #selector(FetchJson), with: .none, waitUntilDone: true)
    }
    
    @objc func FetchJson(){
        if let path = Bundle.main.path(forResource: "countries", ofType: "txt")
        {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path ), options: .mappedIfSafe){
                parse(json: data)
                return
            }
            print("hata1")
        }
        performSelector(onMainThread: #selector(ShowError), with: nil, waitUntilDone: false)
    }
    @objc func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonCountries = try? decoder.decode([Country].self, from: json)
        {
            countries = jsonCountries
            tempCountries = jsonCountries
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
        }
        else{
            performSelector(onMainThread: #selector(ShowError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func ShowError(){
        let ac = UIAlertController(title: "Bağlantı Hatası", message: "Bağlantı kurulurken bir hata meydana geldi. Lütfen bağlantınızı kontrol ediniz ve tekrar deneyiniz.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterText(){
        let ac = UIAlertController(title: "Search for country name , Native name or Capital city name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .default,handler: getBackAllCountries))
        let text = UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac]_ in
            guard let text = ac?.textFields?[0].text else{return}
            self?.filterCountries(text: text)
        }
        ac.addAction(text)
        present(ac,animated: true)
    }
    
    func filterCountries(text:String){
        var count = 0
        for item in countries {
            var capital = ""
            
            if let tempCapital = item.capital {
                capital = tempCapital
            }
            
            if item.name.lowercased().contains(text.lowercased()){
                filteredCountryArray.append(item)
                count += 1
            }
            else if item.nativeName.lowercased().contains(text.lowercased()){
                filteredCountryArray.append(item)
                count += 1
            }
            else if capital.lowercased().contains(text.lowercased()){
                filteredCountryArray.append(item)
                count += 1
            }
        }
        if count>0{
            countries.removeAll()
            countries = filteredCountryArray
            filteredCountryArray.removeAll()
            tableView.reloadData()
        }
        else{
            getBackAllCountries(nil)
        }
    }
    
    @objc func getBackAllCountries(_ action:UIAlertAction?){
        countries.removeAll()
        countries = tempCountries
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.detailTextLabel?.text = countries[indexPath.row].capital
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countryViewController = storyboard?.instantiateViewController(withIdentifier: "Country")as? CountryViewController
        {
            countryViewController.country = [countries[indexPath.row].self]
            navigationController?.pushViewController(countryViewController, animated: true)
        }
    }
}

