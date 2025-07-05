//
//  BottomNavigatorInteractor.swift
//  BottomNavigator
//
//  Created by Rodrigo Dias on 05/07/25.
//

protocol BottomNavigatorPresenting {
    func presentGoToTab(viewModel: BottomNavigator.GoToTab.ViewModel)
}

class BottomNavigatorInteractor: BottomNavigatorInteracting {
    private let presenter: BottomNavigatorPresenter
    
    init(presenter: BottomNavigatorPresenter) {
        self.presenter = presenter
    }
    
    func handleGoToTab(request: BottomNavigator.GoToTab.Request) {
        presenter.presentGoToTab(viewModel: .init(tab: request.tab))
    }
}
