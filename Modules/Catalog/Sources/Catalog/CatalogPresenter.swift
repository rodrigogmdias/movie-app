protocol CatalogDisplaying: AnyObject {
    // Define methods for displaying catalog data
}

final class CatalogPresenter: CatalogPresenting {
    weak var display: CatalogDisplaying?
}
