//
//  EventsCalendarView.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import SwiftUI

struct EventsCalendarView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                CalendarView(interval: DateInterval(start:.distantPast, end: .distantFuture))
            }
                    .navigationTitle("Calendar View")
                    
                
                
            
        }
    }
}

struct EventsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        EventsCalendarView()
            
    }
}
