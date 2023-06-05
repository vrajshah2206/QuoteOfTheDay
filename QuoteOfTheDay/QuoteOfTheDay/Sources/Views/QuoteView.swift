//
//  QuoteView.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-04.
//

import SwiftUI

struct QuoteView: View {
    @State private var quotes: [Quote] = loadQuotes() ?? []

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(quotes.indices, id: \.self) { index in
                    VStack {
                        Text(quotes[index].quote)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)
                            .background(
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                            )

                        HStack {
                            Text("- \(quotes[index].author)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                            Button(action: {
                                quotes[index].favourite.toggle()
                                updateFavoriteValue(quoteID: quotes[index].quote_id, isFavorite: quotes[index].favourite)
                            }) {
                                Image(systemName: quotes[index].favourite ? "heart.fill" : "heart")
                                    .foregroundColor(quotes[index].favourite ? .red : .black)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
    }}

//import SwiftUI
//
//struct QuoteView: View {
//    @StateObject private var quoteData = QuoteData()
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 10) {
//                ForEach(quoteData.quotes.indices, id: \.self) { index in
//                    VStack {
//                        Text(quoteData.quotes[index].quote)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .multilineTextAlignment(.center)
//                            .background(
//                                Rectangle()
//                                    .foregroundColor(.blue)
//                                    .cornerRadius(10)
//                            )
//
//                        HStack {
//                            Text("- \(quoteData.quotes[index].author)")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                                .padding(.bottom)
//                            Button(action: {
//                                quoteData.quotes[index].favourite.toggle()
//                                quoteData.updateFavoriteValue(quoteID: quoteData.quotes[index].quote_id, isFavorite: quoteData.quotes[index].favourite)
//                            }) {
//                                Image(systemName: quoteData.quotes[index].favourite ? "heart.fill" : "heart")
//                                    .foregroundColor(quoteData.quotes[index].favourite ? .red : .black)
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            .padding(.vertical)
//        }
//    }
//}

   
struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
