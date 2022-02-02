//
//  ViewController.swift
//  Project2
//
//  Created by BERAT ALTUNTAŞ on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score=0
    var correctAnswer=0
    var askedQues=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        countries+=["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        button1.layer.borderWidth=1
        button2.layer.borderWidth=1
        button3.layer.borderWidth=1
        
        button1.layer.borderColor=UIColor.lightGray.cgColor
        button2.layer.borderColor=UIColor.lightGray.cgColor
        button3.layer.borderColor=UIColor.lightGray.cgColor
        askQue()
        
        navigationItem.rightBarButtonItem=UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(ShowScore))
        
    }
    func askQue(action: UIAlertAction! = nil){
        askedQues+=1
        if askedQues <= 10
        {
            countries.shuffle()
            correctAnswer=Int.random(in: 0...2)
            title=countries[correctAnswer].uppercased() + " Score :\(score)"
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
        }
        else{
           PopUp(2,correct: true)
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag==correctAnswer{
            
            score+=1
            PopUp(0,correct: true)
        }
        else{
            title=countries[correctAnswer].uppercased() + " Score :\(score)"
            score-=1
            PopUp(1, country:countries[sender.tag],correct: false)
        }
    }
    
    func PopUp(_ status:Int,country:String?=nil, correct:Bool?=nil){
        var message=""
        var buttonTitle=""
        
        var popupTitle=title
        switch status{
            case 0:
                message="Score =\(score)"
                buttonTitle="Continue"
                popupTitle="Your Score"
            case 1:
                message="Thats wrong answer. It's \(country!.uppercased()) flag"
                buttonTitle="Okay"
                popupTitle=title
            case 2:
                message="You're answered 10. question and its youre Score :\(score)"
                buttonTitle="Okay"
                popupTitle="Game Over"
            default:
                print("hata")
            }
        let ac = UIAlertController(title: popupTitle, message: message, preferredStyle: .alert)
        if correct!
        {
            ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler:askQue))
        }
        else {
            ac.addAction(UIAlertAction(title: buttonTitle, style: .default))
            
        }
        present(ac,animated: true)
    }
   @objc func ShowScore()
    {
        PopUp(0,correct:false)
    }

}

