//
//  ViewController.swift
//  Project2
//
//  Created by BERAT ALTUNTAŞ on 27.01.2022.
//

import UIKit
import NotificationCenter

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score=0
    var correctAnswer=0
    var askedQues=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remindToPlayGame()
        
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
    
    func remindToPlayGame(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            if granted{
                self.registerCategories()
                let content = UNMutableNotificationContent()
                content.title = "What are you waiting?"
                content.body = "Come on get in and play the game."
                content.sound = .default
                content.userInfo = ["customData":"data"]
                content.categoryIdentifier = "alarm"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
        }
    }
    
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let remindMeLater = UNNotificationAction(identifier: "remindMeLater", title: "Remind Me 2 Hours Later", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [remindMeLater], intentIdentifiers: [])
        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String{
          
            switch response.actionIdentifier{
            case "remindMeLater":
                remindMeLater()
            default:
                break
            }
        }
    }
    func remindMeLater(){
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "We are waiting for you!!"
        content.body = "As you promised us 2 hour is passed come on and play game."
        content.sound = .default
        content.categoryIdentifier = "alarm"
    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
}

