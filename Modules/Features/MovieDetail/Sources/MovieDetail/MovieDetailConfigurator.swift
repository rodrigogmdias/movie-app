import Foundation

public struct MovieDetailConfigurator {
    @MainActor public static func configure(id: Int, title: String, coverImageUrl: URL?) -> MovieDetailView {
        let presenter = MovieDetailPresenter()
        let intercator = MovieDetailInteractor(presenter: presenter, movieID: id)
        let view = MovieDetailView(title: title, coverImageUrl: coverImageUrl, interactor: intercator)
        
        presenter.display = view.viewState
        
        return view
    }
}
