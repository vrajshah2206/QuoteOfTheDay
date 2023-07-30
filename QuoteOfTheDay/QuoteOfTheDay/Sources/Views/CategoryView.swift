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
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(destination: CategoryDetail(category: category)) {
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [colorScheme == .light ? .teal : .white, colorScheme == .light ? .indigo : .gray]),
                                    startPoint: .bottomLeading,
                                    endPoint: .topTrailing
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
                
                .background( colorScheme == .light ?
                             Image("1")
                    .resizable()
                    .edgesIgnoringSafeArea(.all) :  Image("9")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                )
            }
            .padding(.top, 1)
            .padding(.bottom, 1)
            .navigationTitle("Categories")
        }
    }
}
struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
