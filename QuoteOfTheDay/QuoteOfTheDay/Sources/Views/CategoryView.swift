//
//  CategoryView.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-04.
//

import SwiftUI

struct CategoryView: View {
//    let categories:[String] = Categories.categories
    
    let categories = [
        "Wisdom",
        "Inspiration",
        "Humor",
        "Life",
        "Change",
        "Equality",
        "Success",
        "Fashion",
        "Dreams",
        "Courage",
        "Spirituality",
        "Love",
        "Leadership",
        "Imagination",
        "Freedom",
        "Literature",
        "Perseverance",
        "Optimism",
        "Self-Reliance",
        "Art",
        "Faith",
        "Nature",
        "Simplicity",
        "Creativity",
        "Science",
        "Education",
        "Curiosity",
        "Kindness",
        "Philosophy",
        "Empowerment",
        "Knowledge",
        "Innovation",
        "Relationships",
        "Beauty"
    ]

    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination: CategoryDetail(category: category)) {
                                Rectangle()
                                    .foregroundColor(.blue)
                                    .frame(height: 150)
                                    .overlay(
                                        Text(category)
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                    .cornerRadius(10)
                                    .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Categories")
            }
        }
    }
struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
