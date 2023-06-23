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
        
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(quotes.indices, id: \.self) { index in
                        VStack {
                            Text(quotes[index].quote)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(25)
                                .multilineTextAlignment(.center)
                                .frame(width: 350, height: 230)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [.purple, .orange]),
                                                      startPoint: .topLeading,
                                            endPoint: .center
                                                  ))
                                        .frame(width: 350, height: 200)
                                )
                    
                            
                            NavigationLink(destination: AuthorDetailView(author: quotes[index].author,
                                                                         description: quotes[index].author_description ?? "",
                                                                         expertise: quotes[index].author_expertise ?? "",
                                                                         professions: quotes[index].author_professions ?? "",
                                                                         achievements: quotes[index].author_achievements ?? "",
                                                                         detailedData: quotes[index].author_detailed_data ?? "")) {
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
                                            .padding(.bottom)
                                    }
                                }
                            } .frame(width: 350, height: 70, alignment: .trailing)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
