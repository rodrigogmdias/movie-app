enum BottomNavigator {
    enum Tab {
        case catalog
        case favorites
    }

    enum GoToTab {
        struct Request {
            let tab: Tab
        }
        
        struct Response {
            let tab: Tab
        }
        
        struct ViewModel {
            let tab: Tab
        }
    }
}
