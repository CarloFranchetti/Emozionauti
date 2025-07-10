import SwiftUI

struct CalendarView: UIViewRepresentable {
    let interval: DateInterval

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = Calendar(identifier: .gregorian)
        calendarView.availableDateRange = interval

        container.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: container.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            calendarView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No dynamic update needed
    }
}

