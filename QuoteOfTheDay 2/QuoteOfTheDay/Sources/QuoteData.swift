////
////  QuoteData.swift
////  QuoteOfTheDay
////
////  Created by Savan Savani on 2023-06-04.
////
//
//import Foundation
////import Foundation
//
//class QuoteData: ObservableObject {
//    @Published var quotes: [Quote] = []
//
//    init() {
//        loadQuotesFromFavorites()
//    }
//
//    func loadQuotesFromFavorites() {
//        if let loadedQuotes = FavouriteloaderFunction() {
//            self.quotes = loadedQuotes
//        } else {
//            self.quotes = []
//        }
//    }
//
//    func updateFavoriteValue(quoteID: Int, isFavorite: Bool) {
//        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            return
//        }
//
//        let fileURL = documentsURL.appendingPathComponent("quotes.json")
//
//        do {
//            if !FileManager.default.fileExists(atPath: fileURL.path) {
//                guard let bundleURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
//                    return
//                }
//                try FileManager.default.copyItem(at: bundleURL, to: fileURL)
//            }
//
//            let data = try Data(contentsOf: fileURL)
//            var jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)
//
//            if let index = jsonData["quotes"]?.firstIndex(where: { $0.quote_id == quoteID }) {
//                jsonData["quotes"]?[index].favourite = isFavorite
//            }
//
//            let updatedData = try JSONEncoder().encode(jsonData)
//            try updatedData.write(to: fileURL)
//        } catch {
//            print("Error updating JSON data: \(error)")
//        }
//    }
//}
