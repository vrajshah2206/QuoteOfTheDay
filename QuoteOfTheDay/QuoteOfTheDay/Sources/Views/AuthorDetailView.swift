//
//  AuthorDetailView.swift
//  QuoteOfTheDay
//
<<<<<<< Updated upstream
//  Created by Savan Savani on 2023-06-22.
=======
//  Created by Mehul on 2023-06-22.
>>>>>>> Stashed changes
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
            
<<<<<<< Updated upstream
=======
            Text("Detailed Data:\n\(detailedData)")
                .font(.body)
                .padding()
            
>>>>>>> Stashed changes
            Text("Expertise: \(expertise)")
                .font(.body)
                .padding()
            
            Text("Professions: \(professions)")
                .font(.body)
                .padding()
            
            Text("Achievements: \(achievements)")
                .font(.body)
                .padding()
            
<<<<<<< Updated upstream
            Text("Detailed Data:\n\(detailedData)")
                .font(.body)
                .padding()
            
=======
>>>>>>> Stashed changes
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
