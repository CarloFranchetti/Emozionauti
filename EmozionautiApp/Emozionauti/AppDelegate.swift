import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    static let instance = AppDelegate()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if let error = error {
                print("Errore: \(error)")
            } else {
                print("Autorizzazione notifiche concessa")
            }
        }
    }

    func scheduleNotification(atHour hour: Int, minute: Int) {
        // Rimuovi notifiche precedenti
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Emozionauti"
        content.body = "Prenditi un momento per esprimere le tue emozioni"
        content.sound = .default
        content.badge = 1

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: "dailyReminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Errore nella programmazione della notifica: \(error.localizedDescription)")
            } else {
                print("Notifica programmata alle \(hour):\(String(format: "%02d", minute))")
            }
        }
    }
}
