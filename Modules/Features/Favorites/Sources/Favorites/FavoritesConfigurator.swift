@MainActor
public struct FavoritesConfigurator {
    public static func configure() -> FavoritesView {
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor(presenter: presenter)
        let view = FavoritesView(
            interactor: interactor, viewState: FavoritesView.ViewState())

        presenter.display = view.viewState

        return view
    }
}
