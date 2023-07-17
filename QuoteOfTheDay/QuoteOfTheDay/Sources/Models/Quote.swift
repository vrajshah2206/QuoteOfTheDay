//
//  Quote.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-03.
//

import Foundation

struct Quote: Codable {
    let quote_id: Int
    let author: String
    let category: String
    let quote: String
    var favourite: Bool
    let author_description : String?
    let author_expertise : String?
    let author_professions : String?
    let author_achievements: String?
    let author_detailed_data: String?
}
