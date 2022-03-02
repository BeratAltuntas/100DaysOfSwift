//
//  ViewController.swift
//  Project8
//
//  Created by BERAT ALTUNTAŞ on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabels: UILabel!
    var answerslabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var selectedCorrectButtons = [UIButton]()
    var score = 0{
        didSet{
            scoreLabel.text = "Score: " + String(score)
        }
    }
    var level = 1
    var maxWriteSyllable = 0
    
    
    var shuffeledSyllableArray = [String]()
    var cluesArray = [String]()
    var answersArray = [String]()
    var answeredQues = [String]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(scoreLabel)
        
        cluesLabels = UILabel()
        cluesLabels.translatesAutoresizingMaskIntoConstraints = false
        cluesLabels.font = UIFont.systemFont(ofSize: 24)
        cluesLabels.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabels.text = "CLUES"
        cluesLabels.numberOfLines = 0
        view.addSubview(cluesLabels)
        
        answerslabel = UILabel()
        answerslabel.translatesAutoresizingMaskIntoConstraints = false
        answerslabel.font = UIFont.systemFont(ofSize: 24)
        answerslabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerslabel.text = "ANSWERS"
        answerslabel.textAlignment = .right
        answerslabel.numberOfLines = 0
        view.addSubview(answerslabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(SubmitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(ClearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabels.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabels.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabels.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            answerslabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answerslabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerslabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answerslabel.heightAnchor.constraint(equalTo: cluesLabels.heightAnchor),
            
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabels.bottomAnchor, constant: 30),
            
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            
            clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor,constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor,constant: -20),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 350),
            buttonsView.widthAnchor.constraint(equalToConstant: 750)
        ])
        let width = 150
        let heigth = 80
        
        for row in 0..<4{
            for column in 0..<5{
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("WWW", for: .normal)
                
                let frame = CGRect(x: column * width, y: row * heigth, width: width, height: heigth)
                letterButton.frame = frame
                letterButton.addTarget(self, action: #selector(LetterTapped), for: .touchUpInside)
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        performSelector(inBackground: #selector(SplitWords), with: nil)
    }
    
    @objc func SplitWords(_ action: UIAlertAction?){
        
        var allWords = [String]()
        if let wordsPath = Bundle.main.path(forResource: "level"+String(level), ofType: ".txt"){
            if let textWords = try? String(contentsOfFile: wordsPath) {
                allWords = textWords.components(separatedBy: "\n")
            }
        }
        var count = 0
        for word in allWords {
            let charColon : Character = ":"
            let splited = word.split(separator: charColon)
            let splitedSyllables = splited[0].split(separator: "|")
            var answer=""
            for splitedSyllable in splitedSyllables {
                answer += splitedSyllable
                shuffeledSyllableArray.append(String(splitedSyllable))
            }
            answersArray.append(answer)
            shuffeledSyllableArray.shuffle()
            cluesArray.append(String(splited[1]))
            count += 1
        }
        performSelector(onMainThread: #selector(ChangeTextsAndLabels), with: nil, waitUntilDone: false)
    }
    
    @objc func ChangeTextsAndLabels(){
        cluesLabels.text! = "\n"
        answerslabel.text! = "\n"
        
        for clue in cluesArray {
            cluesLabels.text! += clue + "\n"
        }
        for answer in answersArray {
            answerslabel.text! += "\(answer.count) letters\n"
            answeredQues.append(String("\(answer.count) letters\n"))
        }
        
        var indx = 0
        for syllable in shuffeledSyllableArray {
            letterButtons[indx].setTitle(syllable, for: .normal)
            
            letterButtons[indx].layer.borderColor = UIColor.gray.cgColor
            letterButtons[indx].layer.cornerRadius = CGFloat(15)
            letterButtons[indx].layer.borderWidth = 0.5
            indx += 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @objc func LetterTapped (_ sender: UIButton){
        if maxWriteSyllable < 3{
            selectedCorrectButtons.append(sender)
            currentAnswer.text! += sender.titleLabel!.text!
//
//            UIView.animate(withDuration: 1.5, delay: 0.2, usingSpringWithDamping: 2, initialSpringVelocity: 10, options: []) {
//                sender.alpha = 0
//            } completion: { finished in
//
//            }
            
            //Animasyonlu bir şekilde fade out oluyor butonlar
            UIView.animate(withDuration: 1.2, delay: 0, options: []) {
                sender.alpha = 0
            } completion: { finished in
                
            }

            activatedButtons.append(sender)
        }
        else{
            let ac = UIAlertController(title: "Warning", message: "You can write max 3 syllable word.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac,animated: true)
        }
        maxWriteSyllable += 1
    }
    
    
    @objc func SubmitTapped (_ sender: UIButton){
        var i = 0
        for que in answeredQues {
            if currentAnswer.text!+"\n" == que{
                ClearTapped(nil)
                return
            }
        }
        for answer in answersArray {
            if currentAnswer.text! == answer{
                score+=10
                for selectedCorrectButton in selectedCorrectButtons {
                    selectedCorrectButton.backgroundColor = .green
                }
                selectedCorrectButtons.removeAll()
                answeredQues[i] = answer+"\n"
                ClearTapped(nil)
                break
            }
            i+=1
        }
        if i==7{
            score-=5
            let ac = UIAlertController(title: "Wrong Answer", message: "Your answer is a wrong. Try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
        
        answerslabel.text! = "\n"
        
        for answeredQue in answeredQues {
            answerslabel.text! += answeredQue
        }
        CheckLevelStatus()
        
    }
   func CheckLevelStatus(){
        var allKnown=0
        for i in 0..<7{
            for j in 0..<7{
                if answersArray[i]+"\n" == answeredQues[j]{
                    allKnown+=1
                }
            }
        }
        
        if allKnown == 7{
            level=2
            shuffeledSyllableArray.removeAll()
            currentAnswer.text!=""
            answeredQues.removeAll()
            answerslabel.text=""
            cluesLabels.text=""
            maxWriteSyllable=0
            answersArray.removeAll()
            cluesArray.removeAll()
            let ac = UIAlertController(title: "Passed Level 1", message: "Level 1 is finished. Now Level 2", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default,handler: SplitWords))
            present(ac, animated: true)
            
        }
    }
    
    @objc func ClearTapped (_ sender: UIButton?){
        currentAnswer.text = ""
        maxWriteSyllable = 0
        for activatedButton in activatedButtons {
            activatedButton.alpha = 1
        }
        activatedButtons.removeAll()
        
        
        
    }
}

