import SwiftUI

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            LogoutView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }.environmentObject(model)
    }
}
