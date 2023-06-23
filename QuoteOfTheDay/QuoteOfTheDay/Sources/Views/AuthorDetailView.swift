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
        VStack {
            Text(author)
                .font(.title)
                .padding()
            
            Text(description)
                .font(.body)
                .padding()
            

            Text("Expertise: \(expertise)")
                .font(.body)
                .padding()
            
            Text("Professions: \(professions)")
                .font(.body)
                .padding()
            
            Text("Achievements: \(achievements)")
                .font(.body)
                .padding()
                        Text("Detailed Data:\n\(detailedData)")
                .font(.body)
                .padding()
            
            Spacer()
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
