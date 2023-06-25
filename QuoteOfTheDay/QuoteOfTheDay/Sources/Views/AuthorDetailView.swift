//
//  AuthorDetailView.swift
//  QuoteOfTheDay
//
//  Created by Savan Savani on 2023-06-22.
//

import SwiftUI

struct AuthorDetailView: View {
    let author: String
    let description: String
    let expertise: String
    let professions: String
    let achievements: String
    let detailedData: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(author)
                    .font(.largeTitle)
                    .padding(.horizontal)
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Expertise:")
                        .font(.headline)
                    
                    Text(expertise)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Professions:")
                        .font(.headline)
                    
                    Text(professions)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Achievements:")
                        .font(.headline)
                    
                    Text(achievements)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Detailed Data:")
                        .font(.headline)
                    
                    Text(detailedData)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Author Details")
    }
}
struct AuthorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorDetailView(author: "Albert Einstein",
                         description: "Albert Einstein was a German-born theoretical physicist...",
                         expertise: "Physics, Mathematics",
                         professions: "Physicist, Mathematician",
                         achievements: "Nobel Prize in Physics (1921)",
                         detailedData: "Albert Einstein revolutionized our understanding of the fundamental laws of the universe...")
    }
}
