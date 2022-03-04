//
//  ViewController.swift
//  Day59Challenge
//
//  Created by BERAT ALTUNTAŞ on 4.03.2022.
//

import UIKit


class ViewController: UITableViewController {
    var countries = [Country]()
    var urlString = "https://www.restcountries.com/v2/all"
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.async
//        { [weak self] in
//            guard let urlstr = self?.urlString else{return}
//
//            if let url = URL(string: urlstr){
//                if let data = try? Data(contentsOf: url){
//                    self?.parse(json: data)
//                    return
//                }
//            }
//            self?.ShowError()
//        }

        FetchJson()
    }
    
    @objc func FetchJson(){
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url, options: .alwaysMapped){
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(ShowError), with: nil, waitUntilDone: false)
    }
    @objc func parse(json: Data){
        let decoder = JSONDecoder()
        if let jsonCountries = try? decoder.decode(Countries.self, from: json)
        {
            countries = jsonCountries.results
            
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        cell.detailTextLabel?.text = countries[indexPath.row].capital
        return cell
    }
}

