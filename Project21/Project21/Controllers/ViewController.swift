//
//  ViewController.swift
//  Project21
//
//  Created by BERAT ALTUNTAŞ on 18.03.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
    }
    
    @objc func registerLocal(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            
            if granted{
                print("Yayy!")
            }else{
                print("D'ohh!")
            }
        }
    }
    
    @objc func scheduleLocal(){
        registerCategories()
        let center = UNUserNotificationCenter.current()
        
        //bildirimde nelerin görüntüleneceği, içerik
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData":"fizzbuzz"]
        content.sound = .default
        
        
        //bildirimin ne zaman görüntüleneceği
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        //verilen belirli zamanda bir veya birden fazla kez bildirim gönderilir.
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        // belirlenen sürede bir veya birden fazla kez bildirim gönderilir.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats:false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let remindMeLater = UNNotificationAction(identifier: "remindeMeLater", title: "Remind Me Later", options:.foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show,remindMeLater], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String{
            print("Custom data received: \(customData)")
            var message = ""
            
            switch response.actionIdentifier{
            case UNNotificationDefaultActionIdentifier:
                // kullanıcı sürükleyip açması geerek
                message = "Default identifier"
                print("Default identifier")
            case "show":
                message = "Show more information"
                print("Show more information")
            case "remindeMeLater":
                message = "Remind Me Later"
                remindLater()
            default:
                break
            }
            let ac = UIAlertController(title: "Did received action identifier type", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
        }
        completionHandler()
    }
    
    func remindLater(){
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese. I said these things 12 hour ago."
        content.sound = .default
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData":"fizzbuzz"]
        
        //let dateComponents = DateComponents()
        //dateComponents.hour = Int( Date.now.formatted(.dateTime.hour()))
        //dateComponents.minute = Int(Date.now.formated(.dateTime.minute()))
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
}

