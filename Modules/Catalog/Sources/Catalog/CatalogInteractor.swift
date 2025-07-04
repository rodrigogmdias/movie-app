protocol CatalogPresenting {
    // Define methods for interaction with the catalog
}

final class CatalogInteractor: CatalogInteracting {
    private let presenter: CatalogPresenting

    init(presenter: CatalogPresenting) {
        self.presenter = presenter
    }
}
