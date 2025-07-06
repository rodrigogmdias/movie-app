protocol BottomNavigatorDisplaying: AnyObject {
    func displayGoToTab(viewModel: BottomNavigator.GoToTab.ViewModel)
}

class BottomNavigatorPresenter: BottomNavigatorPresenting {
    
    weak var display: BottomNavigatorDisplaying?
    
    func presentGoToTab(viewModel: BottomNavigator.GoToTab.ViewModel) {
        display?.displayGoToTab(viewModel: .init(tab: viewModel.tab))
    }

}
