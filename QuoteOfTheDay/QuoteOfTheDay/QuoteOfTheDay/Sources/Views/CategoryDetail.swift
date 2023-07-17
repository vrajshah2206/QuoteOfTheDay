import SwiftUI

struct CategoryDetail: View {
    let category: String
    @State private var quotes: [Quote] = []
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            List(quotes, id: \.quote_id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.quote)
                        .font(.headline)
                        .padding(10)
                    Text("- \(quote.author)")
                        .font(.subheadline)
                        .padding(10)
                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .orange : .white]),
                            startPoint: .bottomLeading,
                            endPoint: .bottomTrailing
                        ))
                        .padding(.vertical, -10)
                        .padding(.horizontal, -60)
                )
                .padding(.vertical,20)
                .foregroundColor(colorScheme == .light ? .white : .black)
                .listRowSeparator(.hidden)
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
