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
                            .padding(.bottom, 1)
                        Text("- \(quoteData.favouriteQuotes[index].author)")
                            .font(.system(size: 14, design: .monospaced))
                        Spacer()
                        Divider()
                        HStack(alignment: .bottom) {
                            Text("Category: \(quoteData.favouriteQuotes[index].category)")
                                .font(.system(size: 12, design: .rounded))
                                .padding(10)
                            Spacer()
                           
                            Button(action: {
                                quoteData.updateFavoriteValue(quoteID: quoteData.favouriteQuotes[index].quote_id, isFavorite: !quoteData.favouriteQuotes[index].favourite)
                            }) {
                                Image(systemName: quoteData.favouriteQuotes[index].favourite ? "heart.fill" : "heart")
                                    .foregroundColor(quoteData.favouriteQuotes[index].favourite ? .red : colorScheme == .light ? .black : .white)
                                    .padding(10)
                                    .font(.system(size: 30))
                                
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
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
        .padding(.top, 1)
        .padding(.bottom, 1)
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
