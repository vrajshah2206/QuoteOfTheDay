import SwiftUI
import UIKit
import AVFoundation

struct QuoteView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var quoteData = QuoteData()
    @State private var searchText = ""
    @State private var isAuthorSelected = false
    @State private var quoteToSave: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private let imageSavingHelper = ImageSavingHelper()
    private let synthesizer = AVSpeechSynthesizer()
    
    private func shareQuoteOnSocialMedia(quote: String) {
        let activityViewController = UIActivityViewController(activityItems: [quote], applicationActivities: nil)
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            activityViewController.popoverPresentationController?.sourceView = topViewController.view
        }
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    var filteredQuotes: [Quote] {
        if searchText.isEmpty {
            return quoteData.quotes
        } else {
            return quoteData.quotes.filter { quote in
                quote.quote.lowercased().contains(searchText.lowercased()) ||
                quote.author.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing:10) {
                SearchBar(text: $searchText)
                ScrollView {
                    VStack(spacing: 1) {
                        ForEach(filteredQuotes.indices, id: \.self) { index in
                            VStack {
                                Text(filteredQuotes[index].quote)
                                
                                    .font(.headline)
                                    .foregroundColor(colorScheme == .light ? .white : .black)
                                    .padding(15)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 350, height: 230)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: [colorScheme == .light ? .purple : .gray, colorScheme == .light ? .orange : .white]),
                                                startPoint: .bottomLeading,
                                                endPoint: .bottomTrailing
                                            ))
                                            .frame(width: 350, height: 230))
                                
                                NavigationLink(destination: AuthorDetailView(author: filteredQuotes[index].author,
                                                                             description: filteredQuotes[index].author_description ?? "",
                                                                             expertise: filteredQuotes[index].author_expertise ?? "",
                                                                             professions: filteredQuotes[index].author_professions ?? "",
                                                                             achievements: filteredQuotes[index].author_achievements ?? "",
                                                                             detailedData: filteredQuotes[index].author_detailed_data ?? "")) {
                                    VStack {
                                        Text("- \(filteredQuotes[index].author)")
                                        
                                            .font(.footnote)
                                            .underline()
                                            .foregroundColor(.blue)
                                            .padding(.bottom)
                                    }
                                }
                                                                             .frame(width: 350, height: 50,alignment: .bottomTrailing)
                                GeometryReader { geometry in
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Button(action: {
                                            quoteToSave = filteredQuotes[index].quote
                                            saveQuoteAsImage()
                                        }) {
                                            Text("Save")
                                                .padding(.vertical)
                                                .frame(width: geometry.size.width / 4)
                                                .font(.headline)
                                        }
                                       // Spacer()
                                        Divider()
                                      //  Spacer()
                                        Button(action: {
                                            toggleFavorite(for: filteredQuotes[index])
                                        }) {
                                            Image(systemName: quoteData.quotes[index].favourite ? "heart.fill" : "heart")
                                                .font(.system(size: 30))
                                                .foregroundColor(quoteData.quotes[index].favourite ? .red : colorScheme == .light ? .black : .white)
                                            
                                                .frame(width: geometry.size.width / 4)
                                        }
                                       // Spacer()
                                        Divider()
                                       // Spacer()
                                        
                                        Button(action: {
                                            let quoteToRead = filteredQuotes[index].quote
                                            readQuoteAloud(quote: quoteToRead)
                                        }) {
                                            Image(systemName: "speaker.zzz")
                                                .font(.system(size: 30))
                                                .foregroundColor(.black)
                                                .frame(width: geometry.size.width / 4)
                                                .font(.headline)
                                            
                                           // Text("Listen")
                                             //   .font(.headline)
                                               // .padding(.vertical)
                                                
                                            
                                        }
                                        Divider()
                                        
                                        
                                        
                                        
                                        Button(action: {
                                            let quote = filteredQuotes[index].quote
                                            shareQuoteOnSocialMedia(quote: quote)
                                        }) {
                                            Text("Share")
                                                .font(.headline)
                                               // .padding(.vertical)
                                                .frame(width: geometry.size.width / 4)
                                                .font(.headline)
                                                
                                            //Image(systemName: "square.and.arrow.up")
                                              //  .foregroundColor(.blue)
                                        }
                                    
                                    }
                                    
                                }
                                .frame(width: 350, height: 60, alignment: .leading)
                                .background(Color.white.opacity(0.6))
                                .padding(.bottom, 50)
                                Divider()
                                
                                
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                        }
                    }
                    
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Image Saved"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                    .padding(.vertical)
                }
                .padding(.top, 1)
                .padding(.bottom, 1)
                
            }
            
            .background(colorScheme == .light ?
                        Image("12")
                .resizable()
                .edgesIgnoringSafeArea(.all) :  Image("15")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            )
        }
        .padding(.top, 1)
        .padding(.bottom, 1)
        .onAppear {
            quoteData.loadQuotes()
            
        }
    }
    
    private func toggleFavorite(for quote: Quote) {
        if let index = quoteData.quotes.firstIndex(where: { $0.quote_id == quote.quote_id }) {
            quoteData.updateFavoriteValue(quoteID: quote.quote_id, isFavorite: !quoteData.quotes[index].favourite)
        }
    }
    
    func saveQuoteAsImage() {
        // Convert SwiftUI view (Text) to a UIImage
        let image = textToImage(quote: quoteToSave, size: CGSize(width: 350, height: 200))
        
        // Save the UIImage using the ImageSavingHelper
        imageSavingHelper.saveImage(image)
        imageSavingHelper.completion = { success in
            DispatchQueue.main.async {
                showAlert = true
                alertMessage = success ? "Image saved successfully!" : "Failed to save image."
            }
        }
    }
    
    func readQuoteAloud(quote: String) {
        let utterance = AVSpeechUtterance(string: quote)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // You can adjust the language if needed
        synthesizer.speak(utterance)
    }
    
}
func textToImage(quote: String, size: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    let image = renderer.image { context in
        // Set the background colors using a gradient
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [UIColor.purple.cgColor, UIColor.orange.cgColor] as CFArray, locations: [0, 1])!
        context.cgContext.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: size.width, y: size.height), options: [])
        
        // Set the text attributes for the quote text
        let textFont = UIFont.boldSystemFont(ofSize: 20)
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: UIColor.white,
            .paragraphStyle: NSParagraphStyle()
        ]
        
        // Create attributed string
        let attributedQuote = NSAttributedString(string: quote, attributes: textAttributes)
        
        // Calculate the size of the text with padding on both sides
        let padding: CGFloat = 10
        let textSize = attributedQuote.boundingRect(with: CGSize(width: size.width - 2 * padding, height: size.height),
                                                    options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                    context: nil).size
        
        // Calculate the position to center the text
        let textX = (size.width - textSize.width) / 2
        let textY = (size.height - textSize.height) / 2
        
        // Draw the text at the centered position with padding on both sides
        attributedQuote.draw(in: CGRect(x: textX + padding, y: textY, width: size.width - 2 * padding, height: size.height))
    }
    
    return image
}


struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            TextField("Search Quote || Author", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Button(action: {
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .opacity(text.isEmpty ? 0.0 : 1.0)
            }
        }
        .padding()
    }
}
class ImageSavingHelper: NSObject {
    var completion: ((Bool) -> Void)?
    
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Image saving error: \(error.localizedDescription)")
            completion?(false)
        } else {
            print("Image saved successfully!")
            completion?(true)
        }
    }
}


