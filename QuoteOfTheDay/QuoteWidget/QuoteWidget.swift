import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quote: quotes.first!)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quote: quotes.first!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, quote: quotes.randomElement()!)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: Quote
}

struct QuoteWidgetEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallQuoteView(entry: entry)
        case .systemMedium:
            MediumQuoteView(entry: entry)
        case .systemLarge:
            LargeQuoteView(entry: entry)
        @unknown default:
            Text("Unsupported widget size")
        }
    }
}

struct SmallQuoteView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Text(entry.quote.quote)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

struct MediumQuoteView: View {
    var entry: SimpleEntry

    var body: some View {
        
        VStack {
            Spacer()
            Text(entry.quote.quote)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)

            Text("- \(entry.quote.author)")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct LargeQuoteView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack {
            Spacer()
            Text(entry.quote.quote)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)

            Text("- \(entry.quote.author)")
                .font(.headline)
                .foregroundColor(.gray)

            Spacer() // Center content vertically
        }
    }
}

struct QuoteWidget: Widget {
    let kind: String = "QuoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quote Widget")
        .description("This is an example widget.")
    }
}

struct Quote: Codable, Identifiable {
    let id = UUID()
    let author: String
    let quote: String
}


struct QuoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: Quote(author: "Author Name", quote: "This is a sample quote.")))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: Quote(author: "Author Name", quote: "This is a sample quote.")))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            QuoteWidgetEntryView(entry: SimpleEntry(date: Date(), quote: Quote(author: "Author Name", quote: "This is a sample quote.")))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

let quotes: [Quote] = [
    Quote(author: "Albert Einstein", quote: "Imagination is more important than knowledge."),
    Quote(author: "Maya Angelou", quote: "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel."),
    Quote(author: "Mark Twain", quote: "Get your facts first, then you can distort them as you please."),
    Quote(author: "Oscar Wilde", quote: "To live is the rarest thing in the world. Most people exist, that is all."),
    Quote(author: "Martin Luther King Jr.", quote: "Injustice anywhere is a threat to justice everywhere."),
    Quote(author: "Ralph Waldo Emerson", quote: "Adopt the pace of nature: her secret is patience."),
    Quote(author: "William Shakespeare", quote: "Love all, trust a few, do wrong to none."),
    Quote(author: "Steve Jobs", quote: "Innovation distinguishes between a leader and a follower."),
    Quote(author: "Jane Austen", quote: "There is no charm equal to tenderness of heart."),
    Quote(author: "Nelson Mandela", quote: "The brave man is not he who does not feel afraid, but he who conquers that fear."),
    Quote(author: "Emily Dickinson", quote: "Hope is the thing with feathers that perches in the soul and sings the tune without the words and never stops at all."),
    Quote(author: "Walt Disney", quote: "All our dreams can come true, if we have the courage to pursue them."),
    Quote(author: "Malala Yousafzai", quote: "One child, one teacher, one book, one pen can change the world."),
    Quote(author: "Pablo Picasso", quote: "Every child is an artist. The problem is how to remain an artist once we grow up."),
    Quote(author: "Mother Teresa", quote: "Spread love everywhere you go. Let no one ever come to you without leaving happier."),
    Quote(author: "Vincent van Gogh", quote: "I dream my painting, and then I paint my dream."),
    Quote(author: "Helen Keller", quote: "The only thing worse than being blind is having sight but no vision."),
    Quote(author: "J.K. Rowling", quote: "It is our choices that show what we truly are, far more than our abilities."),
    Quote(author: "Abraham Lincoln", quote: "Nearly all men can stand adversity, but if you want to test a man's character, give him power."),
    Quote(author: "Maya Angelou", quote: "I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel."),
    Quote(author: "Albert Einstein", quote: "The true sign of intelligence is not knowledge but imagination."),
    Quote(author: "Audrey Hepburn", quote: "The beauty of a woman is not in a facial mode but the true beauty in a woman is reflected in her soul. It is the caring that she lovingly gives, the passion that she shows."),
    Quote(author: "Mark Twain", quote: "The secret of getting ahead is getting started."),
    Quote(author: "Rosa Parks", quote: "Each person must live their life as a model for others."),
    Quote(author: "Vincent Van Gogh", quote: "I would rather die of passion than of boredom.")
]
