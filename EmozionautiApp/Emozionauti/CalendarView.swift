import UIKit

class CalendarView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        createCalendar()
        
    }
    func createCalendar() {
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.delegate = self

        view.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),// aggiungi per altezza
            calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

}

extension CalendarView: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponent: DateComponents)-> UICalendarView.Decoration? {
        return nil
    }
}

#Preview{
    CalendarView()
}
