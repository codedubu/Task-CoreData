//
//  NotifcationScheduler.swift
//  Task-CoreData
//
//  Created by River McCaine on 1/20/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotifications(task: Task) {
        guard let dueDate = task.dueDate,
              let id = task.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "DUE DATE!"
        content.body = "It's time to finish \(task.name ?? "task")!"
        content.sound = .defaultCritical
        
        //Notifies user 15 minutes before its actually due.
        let earlierDate = Calendar.current.date(byAdding: .minute, value: -15, to: dueDate)
        
        let dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: earlierDate ?? dueDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notifcation request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotifications(task: Task) {
        guard let id = task.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        
    }
    
}// End of class




