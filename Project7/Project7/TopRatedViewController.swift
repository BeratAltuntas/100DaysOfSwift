//
//  TopRatedViewController.swift
//  Project7
//
//  Created by BERAT ALTUNTAŞ on 6.02.2022.
//

import UIKit

class TopRatedViewController: UITableViewController {
    let urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
    var petitions = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self,action: #selector(ShowSourceFromWhere))
        
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        ShowError()
    }
    
    @objc func ShowSourceFromWhere(){
        let ac = UIAlertController(title: "Kaynak", message: urlString, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .cancel))
        present(ac,animated: true)
    }
    func ShowError(){
        let ac = UIAlertController(title: "Bağlantı Hatası", message: "Bağlantı kurulurken bir hata meydana geldi. Lütfen bağlantınızı kontrol ediniz ve tekrar deneyiniz.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(ac, animated: true)
    }
    func parse(json: Data){
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.selectedPetition = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
