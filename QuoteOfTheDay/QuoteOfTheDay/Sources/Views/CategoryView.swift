//
//  CategoryView.swift
//  QuoteOfTheDay
//
//  Created by vikas  on 2023-06-04.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let categories = [
        "Wisdom",
        "Inspiration",
        "Humor",
        "Life",
        "Equality",
        "Dreams",
        "Courage",
        "Love",
        "Leadership",
        "Imagination",
        "Freedom",
        "Literature",
        "Perseverance",
        "Art",
        "Nature",
        "Creativity",
        "Education",
        "Curiosity",
        "Empowerment",
        "Knowledge",
        "Innovation",
        "Beauty"
    ]

    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination: CategoryDetail(category: category)) {
                                Rectangle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .orange : .white]),
                                                  startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                              ))
                                    .frame(height: 150)
                                    .overlay(
                                        Text(category)
                                            .foregroundColor(colorScheme == .light ? .white : .black)
                                            .font(.title3)
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
