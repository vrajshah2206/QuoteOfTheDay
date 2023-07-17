//
//  QuoteOfTheDayApp.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-01.
//

import SwiftUI

@main
struct QuoteOfTheDayApp: App {
    var body: some Scene {
        WindowGroup {
            DailyQuoteView()
            //ContentView()
        }
    }
    init() {
           LocalNotificationManager.requestPermission()
           LocalNotificationManager.scheduleDailyNotification()
       }

}
