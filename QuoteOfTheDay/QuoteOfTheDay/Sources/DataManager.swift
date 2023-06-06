
//  QuoteLoader.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-03.


import Foundation


//func loadQuotes() -> [Quote]? {
//    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//        return nil
//    }
//
//    let fileURL = documentsURL.appendingPathComponent("quotes.json")
//
//    do {
//        let data = try Data(contentsOf: fileURL)
//        let jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)
//        return jsonData["quotes"]
//    } catch {
//        print("Error loading JSON data: \(error)")
//        return nil
//    }
//}
//

func loadQuotes() -> [Quote]? {
    do {
        let fileManager = FileManager.default
        let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentsURL.appendingPathComponent("quotes.json")
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            
            guard let bundleURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
                print("Quotes file not found in the app bundle.")
                return nil
            }
            try fileManager.copyItem(at: bundleURL, to: fileURL)
        }
        
        let data = try Data(contentsOf: fileURL)
        let jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)
        return jsonData["quotes"]
    } catch {
        print("Error loading JSON data: \(error)")
        return nil
    }
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
        }

        let updatedData = try JSONEncoder().encode(jsonData)
        try updatedData.write(to: fileURL)
    } catch {
        print("Error updating JSON data: \(error)")
    }
}


func CategoryloaderFunction(category: String) -> [Quote]? {

    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }
    let fileURL = documentsURL.appendingPathComponent("quotes.json")

    do {
        let data = try Data(contentsOf: fileURL)
        let jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)

        if let quotes = jsonData["quotes"] {
            let filteredQuotes = quotes.filter { $0.category == category }
            if filteredQuotes.isEmpty {
                return nil
            } else {
                return filteredQuotes
            }
        } else {
            return nil
        }
    } catch {
        print("Error decoding quotes: \(error)")
        return nil
    }
}

func FavouriteloaderFunction() -> [Quote]? {

    guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }
    let fileURL = documentsURL.appendingPathComponent("quotes.json")

    do {
        let data = try Data(contentsOf: fileURL)
        let jsonData = try JSONDecoder().decode([String: [Quote]].self, from: data)

        if let quotes = jsonData["quotes"] {
            let filteredQuotes = quotes.filter { $0.favourite == true }
            if filteredQuotes.isEmpty {
                return nil
            } else {
                return filteredQuotes
            }
        } else {
            return nil
        }
    } catch {
        print("Error decoding quotes: \(error)")
        return nil
    }
}

