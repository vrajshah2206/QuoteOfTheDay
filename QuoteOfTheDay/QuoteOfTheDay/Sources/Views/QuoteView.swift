import SwiftUI

struct QuoteView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var quoteData = QuoteData()
    @State private var searchText = ""
    @State private var isAuthorSelected = false
    
    
    var filteredQuotes: [Quote] {
        if searchText.isEmpty {
            return quoteData.quotes
        } else {
            return quoteData.quotes.filter { quote in
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
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding(25)
                                .multilineTextAlignment(.center)
                                .frame(width: 350, height: 230)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .orange : .white]),
                                            startPoint: .bottomLeading,
                                            endPoint: .bottomTrailing
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
                                        .foregroundColor(colorScheme == .light ? .gray : .white)
                                        .padding(.bottom)
                                    Button(action: {
                                        toggleFavorite(for: filteredQuotes[index])
                                    }) {
                                        Image(systemName: quoteData.quotes[index].favourite ? "heart.fill" : "heart")
                                            .foregroundColor(quoteData.quotes[index].favourite ? .red : colorScheme == .light ? .black : .white)
                                            .padding(.bottom)
                                    }
                                }
                            }.padding(.vertical,-30)
                                .padding(.horizontal,30)
                                .frame(width: 350, height: 70,alignment: .trailing)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear {
            quoteData.loadQuotes()
        }
    }
    
    private func toggleFavorite(for quote: Quote) {
        if let index = quoteData.quotes.firstIndex(where: { $0.quote_id == quote.quote_id }) {
            quoteData.updateFavoriteValue(quoteID: quote.quote_id, isFavorite: !quoteData.quotes[index].favourite)
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
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            TextField("Search Quote || Author", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(colorScheme == .dark ? .white : .black)
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
