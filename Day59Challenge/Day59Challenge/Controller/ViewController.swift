//
//  ViewController.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit


class ViewController: UITableViewController {
    var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()

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
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: true)
        }
        else{
            print("hata2")
            performSelector(onMainThread: #selector(ShowError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func ShowError(){
        let ac = UIAlertController(title: "Bağlantı Hatası", message: "Bağlantı kurulurken bir hata meydana geldi. Lütfen bağlantınızı kontrol ediniz ve tekrar deneyiniz.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(ac, animated: true)
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

