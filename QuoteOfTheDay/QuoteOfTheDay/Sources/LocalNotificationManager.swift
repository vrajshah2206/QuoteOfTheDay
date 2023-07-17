//
//  LocalNotificationManager.swift
//  QuoteOfTheDay
//
//  Created by vraj shah on 2023-07-17.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting permission for local notifications: \(error)")
            } else {
                print("Local notification permission granted.")
            }
        }
    }
    
    static func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Quote of the Day"
        content.body = "Check out the quote of the day!"
        content.sound = .default

        let calendar = Calendar.current
        let now = Date()

        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)

        // Set the desired time for the notification
        components.hour = 7
        components.minute = 0
        components.second = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily notification: \(error)")
            } else {
                print("Daily notification scheduled successfully.")
            }
        }
    }
//    static func scheduleDailyNotification() {
//        let content = UNMutableNotificationContent()
//        content.title = "Quote of the Day"
//        content.body = "Check out the quote of the day!"
//        content.sound = .default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//        let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error scheduling test notification: \(error)")
//            } else {
//                print("Test notification scheduled successfully.")
//            }
//        }
//    }
//

}
