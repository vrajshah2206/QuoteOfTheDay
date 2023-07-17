import Foundation
import UserNotifications
class QuoteData: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var favouriteQuotes: [Quote] = []


    init() {
        loadQuotes()
    }

    func loadQuotes() {
        do {
            let fileManager = FileManager.default
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentsURL.appendingPathComponent("quotes.json")

            if !fileManager.fileExists(atPath: fileURL.path) {
                guard let bundleURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
                    print("Quotes file not found in the app bundle.")
                    return
                }
                try fileManager.copyItem(at: bundleURL, to: fileURL)
            }

            let data = try Data(contentsOf: fileURL)
            let jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)
            self.quotes = jsonData["quotes"] ?? []
        } catch {
            print("Error loading JSON data: \(error)")
        }
        favouriteQuotes = quotes.filter { $0.favourite }

    }

    func updateFavoriteValue(quoteID: Int, isFavorite: Bool) {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        let fileURL = documentsURL.appendingPathComponent("quotes.json")

        do {
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                guard let bundleURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
                    return
                }
                try FileManager.default.copyItem(at: bundleURL, to: fileURL)
            }

            let data = try Data(contentsOf: fileURL)
            var jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)

            if let index = jsonData["quotes"]?.firstIndex(where: { $0.quote_id == quoteID }) {
                jsonData["quotes"]?[index].favourite = isFavorite
                self.quotes = jsonData["quotes"] ?? []
            }

            let updatedData = try JSONEncoder().encode(jsonData)
            try updatedData.write(to: fileURL)
            favouriteQuotes = quotes.filter { $0.favourite }

        } catch {
            print("Error updating favorite value: \(error)")
        }
    }
}
