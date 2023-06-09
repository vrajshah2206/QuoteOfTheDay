
//  RandomQuoteView.swift
//  QuoteOfTheDay
//
//  Created by Vraj on 2023-06-04.


import SwiftUI

struct RandomQuoteView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5

    @State private var randomQuote: Quote?

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

    func generateRandomQuote() {
        randomQuote = quotes.randomElement()
    }

    var body: some View {
        VStack {
            if let quote = randomQuote {
                Text(quote.quote)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()

                Text("\(quote.author)")
                    .font(.title2)
                    .foregroundColor(.gray)
            } else {
                Text("No quotes available")
                    .foregroundColor(.red)
            }
        }
        .onAppear(perform: generateRandomQuote)
    }
}

struct RandomQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        RandomQuoteView()
    }
}
