//
//  FavouriteView.swift
//  QuoteOfTheDay
//
//  Created by Mehul on 2023-06-04.
//
import SwiftUI
struct FavouriteView: View {
    @ObservedObject var quoteData = QuoteData()
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Favourites")
                .font(.title)
                .padding()

            if quoteData.favouriteQuotes.isEmpty {
                Text("Visit Quotes to find your favorite quote.")
                    .font(.subheadline)
                    .padding()
            } else {
                List(quoteData.favouriteQuotes.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(quoteData.favouriteQuotes[index].quote)
                            .font(.headline)
                            .padding(10)
                        Text("- \(quoteData.favouriteQuotes[index].author)")
                            .font(.subheadline)
                            .padding(10)
                        Text("- \(quoteData.favouriteQuotes[index].category)")
                            .font(.subheadline)
                            .padding(10)
                        Button(action: {
                            quoteData.updateFavoriteValue(quoteID: quoteData.favouriteQuotes[index].quote_id, isFavorite: !quoteData.favouriteQuotes[index].favourite)
                        }) {
                            Image(systemName: quoteData.favouriteQuotes[index].favourite ? "heart.fill" : "heart")
                                .foregroundColor(quoteData.favouriteQuotes[index].favourite ? .red : colorScheme == .light ? .black : .white)
                                .padding(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .orange : .white]),
                                startPoint: .bottomLeading,
                                endPoint: .bottomTrailing
                            ))
                            .padding(.vertical, -50)
                            .padding(.horizontal, -100)
                    )
                    .padding(.vertical,60)
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .listRowSeparator(.hidden)
                }
            }
        }
        .navigationTitle("Favourite")
        .onAppear {
            quoteData.loadQuotes()
        }
    }
}


struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
