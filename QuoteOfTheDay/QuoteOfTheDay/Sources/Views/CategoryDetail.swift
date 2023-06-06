//
//  CategoryDetail.swift
//  QuoteOfTheDay
//
//  Created by vikas on 2023-06-04.
//

import SwiftUI

struct CategoryDetail: View {
    let category: String
    @State private var quotes: [Quote] = []
    
    var body: some View {
        VStack {
            Text(category)
                .font(.title)
                .padding()
            
            List(quotes, id: \.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.quote)
                        .font(.headline)
                        .padding(10)
                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .padding(10)
                    Text("- \(quote.category)")
                        .font(.subheadline)
                        .padding(10)
                    
                    Spacer()
                }
                .padding()
            }
            Spacer()
        }
        .navigationTitle(category)
        .onAppear {
            if let loadedQuotes = CategoryloaderFunction(category: category) {
                self.quotes = loadedQuotes
            } else {
                self.quotes = []
            }
        }
    }
}

struct CategoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetail(category: "Wisdom")
    }
}
