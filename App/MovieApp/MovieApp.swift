import BottomNavigator
import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            BottomNavigatorConfigurator.configure()
        }
    }
}
