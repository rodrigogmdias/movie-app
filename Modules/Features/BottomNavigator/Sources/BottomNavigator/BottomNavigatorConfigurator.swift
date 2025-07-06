@MainActor
public struct BottomNavigatorConfigurator {
    public static func configure() -> BottomNavigatorView {
        let presenter = BottomNavigatorPresenter()
        let interactor = BottomNavigatorInteractor(presenter: presenter)
        let view = BottomNavigatorView(
            interactor: interactor, viewState: BottomNavigatorView.ViewState())

        presenter.display = view.viewState

        return view
    }
}
