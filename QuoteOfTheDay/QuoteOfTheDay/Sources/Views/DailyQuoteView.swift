//
//  DailyQuoteView.swift
//  QuoteOfTheDay
//
//  Created by savan on 2023-06-04.
//

import SwiftUI

struct QUOTE: Codable {
    let quote_id: Int
    let author: String
    let category: String
    let quote: String
    let favourite: Bool
}

struct DailyQuoteView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    
    
    
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
                Text("Quote Of The Day")
                    .font(.largeTitle)
                    .position(x:200, y:200)
                
                VStack {
                    Text(randomQuote.quote)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("- \(randomQuote.author)")
                        .font(.title2)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                    
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.isActive = true
                }
            }
        }
    }
        
    struct DailyQuoteView_Previews: PreviewProvider {
            static var previews: some View {
                DailyQuoteView()
            }
        }
    }
