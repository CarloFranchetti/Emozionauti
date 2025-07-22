//
//  AppDelegate.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//
import UserNotifications
import SwiftUI

class AppDelegate:NSObject, UIApplicationDelegate{
    static let instance = AppDelegate()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                print("Errore: \(error)")
            } else {
                print("Success")
                DispatchQueue.main.async {
                    self.scheduleNotification()
                }
            }
        }
    }
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Emozionauti"
        content.body = "Prenditi un momento per esprimere le tue emozioni"
        content.badge = 1
        content.sound = .default
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 38
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString
                                             , content: content,
                                                trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
            application.applicationIconBadgeNumber = 0
        }
}

    

