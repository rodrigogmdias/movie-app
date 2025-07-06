import Catalog
import Favorites
import SwiftUI

protocol BottomNavigatorInteracting: AnyObject {
    func handleGoToTab(request: BottomNavigator.GoToTab.Request)
}

public struct BottomNavigatorView: View {
    let interactor: BottomNavigatorInteracting?
    @ObservedObject var viewState: ViewState
    @State var selectedTab: BottomNavigator.Tab = .catalog

    public var body: some View {
        TabView(selection: $selectedTab) {
            CatalogConfigurator.configure()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(BottomNavigator.Tab.catalog)

            FavoritesConfigurator.configure()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(BottomNavigator.Tab.favorites)
        }
        .tint(.red)
        .onReceive(
            NotificationCenter.default.publisher(for: NSNotification.Name("GoToHome"))
        ) { _ in
            selectedTab = .catalog
            // TODO: colocar a chamada do interactor aqui
        }
    }

    final class ViewState: ObservableObject, BottomNavigatorDisplaying {
        @State var selectedTab: BottomNavigator.Tab = .catalog

        func displayGoToTab(viewModel: BottomNavigator.GoToTab.ViewModel) {
            selectedTab = viewModel.tab
        }
    }
}

struct BottomNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigatorView(interactor: nil, viewState: .init())
    }
}
