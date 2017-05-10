//
//  ViewController.swift
//  iOS10-notifications
//
//  Created by r3d on 10/05/2017.
//  Copyright © 2017 r3d. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in

            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }


    @IBAction func notifyMeButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }

// 2. CREATE NOTIFICATION
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        //Attachment
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }

        var attachment: UNNotificationAttachment

        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)

        //Create notification content
        let notif = UNMutableNotificationContent()
        
        //Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "The new notification options in iOS10 are great!"
        notif.attachments = [attachment]

        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)

        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error!)
                completion(false)
            } else {
                completion(true)
            }
        })

    }
}

