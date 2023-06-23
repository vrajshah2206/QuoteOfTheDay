import SwiftUI

struct QuoteView: View {
    @State private var quotes: [Quote] = loadQuotes() ?? []
    @State private var searchText = ""
    
    var filteredQuotes: [Quote] {
        if searchText.isEmpty {
            return quotes
        } else {
            return quotes.filter { quote in
                quote.quote.lowercased().contains(searchText.lowercased()) ||
                    quote.author.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    SearchBar(text: $searchText)
                    
                    ForEach(filteredQuotes.indices, id: \.self) { index in
                        VStack {
                            Text(filteredQuotes[index].quote)
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
                    
                            
                            NavigationLink(destination: AuthorDetailView(author: filteredQuotes[index].author,
                                                                         description: filteredQuotes[index].author_description ?? "",
                                                                         expertise: filteredQuotes[index].author_expertise ?? "",
                                                                         professions: filteredQuotes[index].author_professions ?? "",
                                                                         achievements: filteredQuotes[index].author_achievements ?? "",
                                                                         detailedData: filteredQuotes[index].author_detailed_data ?? "")) {
                                HStack {
                                    Text("- \(filteredQuotes[index].author)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.bottom)
                                    Button(action: {
                                        toggleFavorite(for: filteredQuotes[index])
                                    }) {
                                        Image(systemName: filteredQuotes[index].favourite ? "heart.fill" : "heart")
                                            .foregroundColor(filteredQuotes[index].favourite ? .red : .black)
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
    
    private func toggleFavorite(for quote: Quote) {
        if let index = quotes.firstIndex(where: { $0.quote_id == quote.quote_id }) {
            quotes[index].favourite.toggle()
            updateFavoriteValue(quoteID: quote.quote_id, isFavorite: quotes[index].favourite)
        }
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search Quote || Author", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(text.isEmpty ? 0.0 : 1.0)
            }
        }
        .padding()
    }
}
