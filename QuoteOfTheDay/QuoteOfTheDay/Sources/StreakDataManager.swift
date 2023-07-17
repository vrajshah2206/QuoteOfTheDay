import Foundation
import UserNotifications
class StreakManager {
    static func getCurrentStreak() -> Int {
        let startDate = UserDefaults.standard.object(forKey: "StreakStartDate") as? Date
        let currentDate = Date()
        
        // Check if streak has been started and the app was launched on a previous day
        if let startDate = startDate, Calendar.current.isDate(startDate, inSameDayAs: currentDate) == false {
            let streak = calculateStreak(startDate: startDate, endDate: currentDate)
            return streak
        } else {
            return 0
        }
    }
    
    static func updateStreak() {
        let startDate = UserDefaults.standard.object(forKey: "StreakStartDate") as? Date
        let currentDate = Date()
        
        // Check if streak has been started and the app was launched on a previous day
        if let startDate = startDate, Calendar.current.isDate(startDate, inSameDayAs: currentDate) == false {
            let streak = calculateStreak(startDate: startDate, endDate: currentDate)
            UserDefaults.standard.set(currentDate, forKey: "StreakStartDate")
            UserDefaults.standard.set(streak, forKey: "StreakCount")
        } else {
            UserDefaults.standard.set(currentDate, forKey: "StreakStartDate")
            UserDefaults.standard.set(1, forKey: "StreakCount")
        }
    }
    
    private static func calculateStreak(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.year, .month, .day], from: startDate)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: endDate)
        
        guard let startDate = calendar.date(from: startComponents),
              let endDate = calendar.date(from: endComponents) else {
            return 0
        }
        
        let numberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return numberOfDays + 1
    }
}
