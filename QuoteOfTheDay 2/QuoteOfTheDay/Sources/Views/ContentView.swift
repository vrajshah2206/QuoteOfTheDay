import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            CategoryView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Category")
                }.tag(0)
            
            QuoteView()
                .tabItem {
                    Image(systemName: "text.quote")
                    Text("Quote")
                }.tag(1)
            
            FavouriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favourite")
                }.tag(2)
        }.onAppear{
            selectedTab = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
