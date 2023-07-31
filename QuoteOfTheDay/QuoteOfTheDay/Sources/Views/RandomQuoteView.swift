
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
    @State private var showAllQuotes = false
    @State private var archivedQuotes: [Quote] = []
    

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
                                    .font(.system(size: 18, design: .rounded))
                                    .frame(width: 350, height: 230)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .foregroundColor(colorScheme == .light ? .white : .black)
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
                                    .font(.system(size: 14, design: .monospaced))
                                    .foregroundColor(.white)
                                
                                
                                Button(action: {
                                    if let randomQuote = randomQuote {
                                        archivedQuotes.append(randomQuote)
                                    }
                                    showAllQuotes.toggle()
                                    generateRandomQuote()
                                }, label: {
                                    Text(showAllQuotes ? "Generate Quote" : "Generate Quote")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .font(.system(size: 14, design: .rounded))
                                })
                                .padding()

                                if !archivedQuotes.isEmpty {
                                    VStack(spacing:10) {
                                        List(archivedQuotes, id: \.quote_id) { quote in
                                            VStack(alignment: .leading) {
                                                Text(quote.quote)
                                                    .foregroundColor(colorScheme == .light ? .white : .black)
                                                    .font(.system(size: 14, design: .rounded))
                                                    .padding(.bottom)
                                                Text("- \(quote.author)")
                                                    .font(.footnote)
                                                    .foregroundColor(.black)
                                            }
                                            .padding(.horizontal)
                                            .frame(width: 350, height: 150)
                                            .frame(maxHeight: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(LinearGradient(
                                                        gradient: Gradient(colors: [colorScheme == .light ? .blue : .gray, colorScheme == .light ? .red : .white]),
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ))
                                                    .frame(width: 350, height: 230))
                                            .cornerRadius(10)
                                           
                                            
                                        }
                                        .listStyle(PlainListStyle())
                                        
                                       
                                        
                                    }
                                   
                                   
                                    
                                }
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
        .padding(.top, 1)
        .padding(.bottom, 1)
        .onAppear(perform: generateRandomQuote)
    }
}

struct RandomQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        RandomQuoteView()
    }
}
