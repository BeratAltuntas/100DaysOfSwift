//
//  ViewController.swift
//  Project6Challenge
//
//  Created by BERAT ALTUNTAŞ on 5.02.2022.
//

import UIKit

class ViewController: UITableViewController {
    var ShoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ItemVeriKontrol))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(ClearItemsInShoppingList))
        
    }
    @objc func ItemVeriKontrol(){
        let ac = UIAlertController(title: "Ürün Girin", message: "Listeye Eklenecek ürün giriniz.", preferredStyle: .alert)
        ac.addTextField()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Ekle", style: .default){
            [weak self, weak ac] _ in
            guard let ShoppingItem = ac?.textFields?[0].text else{return }
            self?.AlisverisListesineEkle(ShoppingItem)
        }
        ac.addAction(cancel)
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    @objc func AlisverisListesineEkle(_ Item:String){
        ShoppingList.append(Item)
        let indexPath = IndexPath(row: ShoppingList.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .bottom)
    }
    
    
    @objc func ClearItemsInShoppingList(){
        ShoppingList.removeAll()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item" ,for: indexPath)
        
        cell.textLabel?.text = ShoppingList[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item" ,for: indexPath)
        if cell.accessoryType == .checkmark{
            cell.accessoryType = .none
        }else{
            cell.accessoryType = .checkmark
        }
        return cell.editingStyle
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.delegate?.tableView!(tableView, editingStyleForRowAt: indexPath)
        
            
        
    }
}

