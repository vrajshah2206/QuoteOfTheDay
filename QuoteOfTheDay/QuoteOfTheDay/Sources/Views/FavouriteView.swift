//
//  FavouriteView.swift
//  QuoteOfTheDay
//
//  Created by Mehul on 2023-06-04.
//

import SwiftUI

struct FavouriteView: View {
    @State private var quotes: [Quote] = []

    var body: some View {
        VStack {
            Text("Favourites")
                .font(.title)
                .padding()

            List(quotes.indices, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text(quotes[index].quote)
                        .font(.headline)
                        .padding(10)
                    Text("- \(quotes[index].author)")
                        .font(.subheadline)
                        .padding(10)
                    Text("- \(quotes[index].category)")
                        .font(.subheadline)
                        .padding(10)
                    Button(action: {
                        quotes[index].favourite.toggle()
                        updateFavoriteValue(quoteID: quotes[index].quote_id,
                        isFavorite: quotes[index].favourite)
                        if !quotes[index].favourite
                        {
                            self.quotes.remove(at: index)
                            }
                    }) {
                        Image(systemName: quotes[index].favourite ? "heart.fill" : "heart")
                            .foregroundColor(quotes[index].favourite ? .red : .black)
                            .padding(10)
                    }
                    Spacer()
                }
                .padding()
            }
            Spacer()
        }
        .navigationTitle("Favourite")
        .onAppear {
            if let loadedQuotes = FavouriteloaderFunction() {
                self.quotes = loadedQuotes
            } else {
                self.quotes = []
            }
        }
    }
}


struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
