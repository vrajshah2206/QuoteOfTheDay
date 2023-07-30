
//  RandomQuoteView.swift
//  QuoteOfTheDay
//
//  Created by Vraj on 2023-06-04.


import SwiftUI

struct RandomQuoteView: View {
    @Environment(\.colorScheme) var colorScheme
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
        NavigationView {
                    VStack {
                        VStack {
                            if let quote = randomQuote {
                                Text(quote.quote)
                                    .font(.title3)
                                    .frame(width: 350, height: 230)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .blue : .white]),
                                                startPoint: .bottomLeading,
                                                endPoint: .bottomTrailing
                                            ))
                                            .frame(width: 350, height: 230))
                                    .cornerRadius(10)
                                
                                
                                Text("\(quote.author)")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            } else {
                                Text("No quotes available")
                                    .foregroundColor(.red)
                            }
                        }
                       
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(3)
                    .background( colorScheme == .light ?
                                 Image("11")
                        .resizable()
                        .edgesIgnoringSafeArea(.all) :  Image("14")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    )
                    
                }
        .onAppear(perform: generateRandomQuote)
    }
}

struct RandomQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        RandomQuoteView()
    }
}
