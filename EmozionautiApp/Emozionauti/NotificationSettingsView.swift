import SwiftUI

struct NotificationSettingsView: View {
    @AppStorage("notificationHour") private var hour: Int = 18
    @AppStorage("notificationMinute") private var minute: Int = 0
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true

    @State private var selectedTime = Date()

    var body: some View {
        Form {
            Section () {
                Toggle("Consenti notifiche", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { value in
                        if value {
                            scheduleNotification()
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }

                DatePicker("Imposta orario notifica", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .onChange(of: selectedTime) { newValue in
                        let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                        hour = components.hour ?? 14
                        minute = components.minute ?? 0
                        if notificationsEnabled {
                            scheduleNotification()
                        }
                    }
            }
        }
        .navigationBarTitle("Notifiche")
            .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            var components = DateComponents()
            components.hour = hour
            components.minute = minute
            selectedTime = Calendar.current.date(from: components) ?? Date()
        }
    }

    func scheduleNotification() {
        AppDelegate.instance.scheduleNotification(atHour: hour, minute: minute)
    }
}
