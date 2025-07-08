import Catalog
import Favorites
import SwiftUI

protocol BottomNavigatorInteracting: AnyObject {
    func handleGoToTab(request: BottomNavigator.GoToTab.Request)
}

public struct BottomNavigatorView: View {
    let interactor: BottomNavigatorInteracting?
    let catalogView = CatalogConfigurator.configure()
    let favoritesView = FavoritesConfigurator.configure()
    
    @ObservedObject var viewState: ViewState

    public var body: some View {
        TabView(selection: $viewState.selectedTab) {
            catalogView
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(BottomNavigator.Tab.catalog)

            favoritesView
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(BottomNavigator.Tab.favorites)
        }
        .tint(.red)
        .onReceive(
            NotificationCenter.default.publisher(for: NSNotification.Name("GoToHome"))
        ) { _ in
            interactor?.handleGoToTab(request: .init(tab: .catalog))
        }
    }

    final class ViewState: ObservableObject, BottomNavigatorDisplaying {
        @Published var selectedTab: BottomNavigator.Tab = .catalog

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
