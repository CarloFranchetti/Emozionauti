//
//  UserNotifications.swift
//  Emozionauti
//
//  Created by Studente on 22/07/25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            completion(granted)
        }
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func scheduleDailyReminder(atHour hour: Int, minute: Int) {
        removeAllNotifications()
    }
}
