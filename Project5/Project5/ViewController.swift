//
//  ViewController.swift
//  Project5
//
//  Created by BERAT ALTUNTAŞ on 1.02.2022.
//

import UIKit

class ViewController: UITableViewController {

    var allWordsInTheText = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(PromptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(Refresh))
        var countSet = Set<Int>()
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let  startWords = try? String(contentsOf: startWordsUrl){
                countSet.insert(startWords.count)
                allWordsInTheText = startWords.components(separatedBy: "\n")
            }
        }
        if allWordsInTheText.isEmpty{
            allWordsInTheText = ["silkworm"]
        }
        print(countSet.count)
        
        StartGame()
    }
    
    func StartGame(){
        title = allWordsInTheText.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word" ,for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func PromptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.Submit(answer)
        }
        ac.addAction(cancel)
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func Refresh(){
        StartGame()
    }
    
    func Submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        if !lowerAnswer.contains(" ") && !lowerAnswer.contains("") && !lowerAnswer.isEmpty{
            if IsPossible(word: lowerAnswer){
                if IsOriginal(word: lowerAnswer){
                    if IsReal(word: lowerAnswer){
                        usedWords.insert(answer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .middle)
                        return
                    }else{
                        ShowErrorMessage(3)
                    }
                }else{
                    ShowErrorMessage(2)
                }
            }else{
                ShowErrorMessage(1)
            }
        }else{
            ShowErrorMessage(0)
        }
    }
    
    
    func IsPossible(word: String) -> Bool{
        guard var tempWord = title?.lowercased() else{return false}
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else{
                return false
            }
        }
        return true
    }
    
    
    func IsOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    
    func IsReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        if word.count > 2{
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            return misspelledRange.location == NSNotFound
        }
        return false
    }
    
    func ShowErrorMessage(_ errorCode: Int){
        let errorTitle: String
        let errorMessage: String
        switch errorCode{
            case 0://Empty word
                errorTitle = "There is no Word."
                errorMessage = "You can't leave it blank!"
                
            case 1://Madeup Not possible word
                errorTitle = "Word not possible."
                errorMessage = "You can't spell that word from \(title!.lowercased())"
                
            case 2://Used word
                errorTitle = "Words already used."
                errorMessage = "Be more original!"
                
            case 3://Not a real word
                errorTitle = "Word not recognized."
                errorMessage = "You can't just make them up, you know!"
            
            default :
                errorTitle = "There is no Word."
                errorMessage = "You can't leave it blank!"
        }
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

