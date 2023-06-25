//
//  DailyQuoteView.swift
//  QuoteOfTheDay
//
//  Created by savan on 2023-06-04.
//

import SwiftUI

struct DailyQuoteView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var streak: Int = 0
    
    let quotes: [Quote] = {
        guard let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
            fatalError("Failed to locate quotes.json file")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let json = try decoder.decode([String: [Quote]].self, from: data)
            return json["quotes"] ?? []
        } catch {
            fatalError("Failed to decode quotes.json: \(error)")
        }
    }()
    
    var randomQuote: Quote {
        guard let quote = quotes.randomElement() else {
            fatalError("No quotes found")
        }
        return quote
    }
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.blue // Background color
                
                VStack {
                    Text("Quote Of The Day")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 90)
                    
                    Text("Current Streak: \(streak) days")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue]), startPoint: .top, endPoint: .bottom)
                )
                
                VStack {
                    Spacer()
                    
                    VStack {
                        Text(randomQuote.quote)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.white)
                        
                        Text("- \(randomQuote.author)")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                updateStreak()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.isActive = true
                }
            }
        }
    }
    
    private func updateStreak() {
        let currentDate: String = {
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: now)
        }()
        
        var savedDate = UserDefaults.standard.string(forKey: "DateSaved")
        
        if let savedDate = savedDate {
            let streak = UserDefaults.standard.integer(forKey: "CountOfStreak")
            let differenceInDays: Int? = {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .none
                guard let currentDate = formatter.date(from: currentDate),
                      let yesterdayDate = formatter.date(from: savedDate) else {
                    return nil
                }
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: yesterdayDate, to: currentDate)
                return components.day
            }()
            
            if let differenceInDays = differenceInDays {
                if differenceInDays == 0 {
                    UserDefaults.standard.set(streak + 0, forKey: "CountOfStreak")
                } else if differenceInDays == 1 {
                    UserDefaults.standard.set(streak + 1, forKey: "CountOfStreak")
                } else {
                    UserDefaults.standard.set(0, forKey: "CountOfStreak")
                }
            } else {
                UserDefaults.standard.set(0, forKey: "CountOfStreak")
            }
            
            UserDefaults.standard.set(currentDate, forKey: "DateSaved")
            self.streak = UserDefaults.standard.integer(forKey: "CountOfStreak")
        } else {
            UserDefaults.standard.set(currentDate, forKey: "DateSaved")
            UserDefaults.standard.set(0, forKey: "CountOfStreak")
            self.streak = 0
        }
    }
}
struct DailyQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        DailyQuoteView()
    }
}
