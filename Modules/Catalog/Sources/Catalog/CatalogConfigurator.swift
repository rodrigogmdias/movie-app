//
//  CatalogConfigurator.swift
//  Catalog
//
//  Created by Rodrigo Dias on 03/07/25.
//

@MainActor
public struct CatalogConfigurator {
    public static func configure() -> CatalogView {
        let viewState = CatalogView.ViewState()
        let presenter = CatalogPresenter()
        let service = CatalogService()
        let interactor = CatalogInteractor(presenter: presenter, service: service)
        let view = CatalogView(interactor: interactor, viewState: viewState)

        presenter.display = viewState

        return view
    }
}
