import Catalog
import Favorites
import SwiftUI

public struct BottomNavigatorView: View {
    enum Tab {
        case home
        case catalog
        case favorites
    }

    @State private var selectedTab: Tab = .home

    public var body: some View {
        TabView(selection: $selectedTab) {
            CatalogConfigurator.configure()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)

            FavoritesConfigurator.configure()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(Tab.favorites)
        }
        .tint(.red)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GoToHome"))) {
            _ in
            selectedTab = .home
        }
    }
}

struct BottomNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigatorView()
    }
}
