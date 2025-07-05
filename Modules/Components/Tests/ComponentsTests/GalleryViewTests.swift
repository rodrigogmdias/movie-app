import SwiftUI
import Testing

@testable import Components

// MARK: - GalleryView.Movie Tests
@Test("Movie model should be created with correct properties")
func testMovieModelCreation() {
    // Given
    let title = "Test Movie"
    let posterURL = URL(string: "https://example.com/poster.jpg")

    // When
    let movie = GalleryView.Movie(title: title, posterURL: posterURL)

    // Then
    #expect(movie.title == title)
    #expect(movie.posterURL == posterURL)
    #expect(movie.id != UUID())  // Should have a unique ID
}

@Test("Movie model should handle nil posterURL")
func testMovieModelWithNilPosterURL() {
    // Given
    let title = "Test Movie"

    // When
    let movie = GalleryView.Movie(title: title, posterURL: nil)

    // Then
    #expect(movie.title == title)
    #expect(movie.posterURL == nil)
}

@Test("Movie model should conform to Identifiable")
func testMovieModelIdentifiable() {
    // Given
    let movie1 = GalleryView.Movie(title: "Movie 1", posterURL: nil)
    let movie2 = GalleryView.Movie(title: "Movie 2", posterURL: nil)

    // Then
    #expect(movie1.id != movie2.id)  // Each movie should have a unique ID
}

// MARK: - GalleryView Initialization Tests
@Test("GalleryView should initialize with default values")
@MainActor
func testGalleryViewDefaultInitialization() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // When
    let galleryView = GalleryView(title: title, movies: movies)

    // Then
    #expect(galleryView.title == title)
    #expect(galleryView.movies.count == 1)
    #expect(galleryView.showMoreButtonAction == nil)
}

@Test("GalleryView should initialize with all parameters")
@MainActor
func testGalleryViewFullInitialization() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]
    var actionCalled = false
    let action = { actionCalled = true }

    // When
    let galleryView = GalleryView(
        title: title,
        status: .loaded,
        movies: movies,
        showMoreButtonAction: action
    )

    // Then
    #expect(galleryView.title == title)
    #expect(galleryView.movies.count == 1)
    #expect(galleryView.showMoreButtonAction != nil)

    // Test the action
    galleryView.showMoreButtonAction?()
    #expect(actionCalled == true)
}

// MARK: - GalleryStatus Tests
@Test("GalleryStatus should support loading state")
func testGalleryStatusLoading() {
    // Given
    let status = GalleryView.GalleryStatus.loading

    // When/Then
    switch status {
    case .loading:
        #expect(Bool(true))  // Test passes if we reach this case
    default:
        #expect(Bool(false), "Status should be loading")
    }
}

@Test("GalleryStatus should support loaded state")
func testGalleryStatusLoaded() {
    // Given
    let status = GalleryView.GalleryStatus.loaded

    // When/Then
    switch status {
    case .loaded:
        #expect(Bool(true))  // Test passes if we reach this case
    default:
        #expect(Bool(false), "Status should be loaded")
    }
}

@Test("GalleryStatus should support failure state with error")
func testGalleryStatusFailure() {
    // Given
    let error = NSError(
        domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
    let status = GalleryView.GalleryStatus.failure(error)

    // When/Then
    switch status {
    case .failure(let receivedError):
        #expect(receivedError.localizedDescription == "Test error")
    default:
        #expect(Bool(false), "Status should be failure")
    }
}

// MARK: - GalleryView Content Tests
@Test("GalleryView should display correct title")
@MainActor
func testGalleryViewTitle() {
    // Given
    let expectedTitle = "Popular Movies"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // When
    let galleryView = GalleryView(title: expectedTitle, movies: movies)

    // Then
    #expect(galleryView.title == expectedTitle)
}

@Test("GalleryView should handle empty movies array")
@MainActor
func testGalleryViewEmptyMovies() {
    // Given
    let title = "Empty Gallery"
    let movies: [GalleryView.Movie] = []

    // When
    let galleryView = GalleryView(title: title, movies: movies)

    // Then
    #expect(galleryView.movies.isEmpty)
}

@Test("GalleryView should handle multiple movies")
@MainActor
func testGalleryViewMultipleMovies() {
    // Given
    let title = "Multiple Movies"
    let movies = [
        GalleryView.Movie(title: "Movie 1", posterURL: URL(string: "https://example.com/1.jpg")),
        GalleryView.Movie(title: "Movie 2", posterURL: URL(string: "https://example.com/2.jpg")),
        GalleryView.Movie(title: "Movie 3", posterURL: nil),
    ]

    // When
    let galleryView = GalleryView(title: title, movies: movies)

    // Then
    #expect(galleryView.movies.count == 3)
    #expect(galleryView.movies[0].title == "Movie 1")
    #expect(galleryView.movies[1].title == "Movie 2")
    #expect(galleryView.movies[2].title == "Movie 3")
    #expect(galleryView.movies[2].posterURL == nil)
}

// MARK: - Show More Button Tests
@Test("GalleryView should not show more button when action is nil")
@MainActor
func testGalleryViewNoShowMoreButton() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // When
    let galleryView = GalleryView(title: title, movies: movies)

    // Then
    #expect(galleryView.showMoreButtonAction == nil)
}

@Test("GalleryView should show more button when action is provided")
@MainActor
func testGalleryViewWithShowMoreButton() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]
    var buttonTapped = false
    let action = { buttonTapped = true }

    // When
    let galleryView = GalleryView(
        title: title,
        movies: movies,
        showMoreButtonAction: action
    )

    // Then
    #expect(galleryView.showMoreButtonAction != nil)

    // Test button action
    galleryView.showMoreButtonAction?()
    #expect(buttonTapped == true)
}

// MARK: - Edge Cases Tests
@Test("GalleryView should handle very long movie titles")
@MainActor
func testGalleryViewLongMovieTitles() {
    // Given
    let longTitle =
        "This is a very long movie title that should be handled gracefully by the gallery view component"
    let movies = [GalleryView.Movie(title: longTitle, posterURL: nil)]

    // When
    let galleryView = GalleryView(title: "Test Gallery", movies: movies)

    // Then
    #expect(galleryView.movies.first?.title == longTitle)
}

@Test("GalleryView should handle valid URLs")
@MainActor
func testGalleryViewValidURL() {
    // Given
    let title = "Test Gallery"
    let validURL = URL(string: "https://example.com/poster.jpg")
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: validURL)]

    // When
    let galleryView = GalleryView(title: title, movies: movies)

    // Then
    #expect(galleryView.movies.first?.posterURL == validURL)
}

// MARK: - Status Behavior Tests
@Test("GalleryView should maintain loading status")
@MainActor
func testGalleryViewLoadingStatus() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // When
    let galleryView = GalleryView(title: title, status: .loading, movies: movies)

    // Then
    switch galleryView.status {
    case .loading:
        #expect(Bool(true))
    default:
        #expect(Bool(false), "Status should be loading")
    }
}

@Test("GalleryView should maintain loaded status")
@MainActor
func testGalleryViewLoadedStatus() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // When
    let galleryView = GalleryView(title: title, status: .loaded, movies: movies)

    // Then
    switch galleryView.status {
    case .loaded:
        #expect(Bool(true))
    default:
        #expect(Bool(false), "Status should be loaded")
    }
}

@Test("GalleryView should maintain failure status")
@MainActor
func testGalleryViewFailureStatus() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]
    let error = NSError(
        domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])

    // When
    let galleryView = GalleryView(title: title, status: .failure(error), movies: movies)

    // Then
    switch galleryView.status {
    case .failure(let receivedError):
        #expect(receivedError.localizedDescription == "Test error")
    default:
        #expect(Bool(false), "Status should be failure")
    }
}

// MARK: - View State Tests
@Test("GalleryView should handle different status states consistently")
@MainActor
func testGalleryViewStatusConsistency() {
    // Given
    let title = "Test Gallery"
    let movies = [GalleryView.Movie(title: "Movie 1", posterURL: nil)]

    // Test loading state
    let loadingView = GalleryView(title: title, status: .loading, movies: movies)
    switch loadingView.status {
    case .loading:
        #expect(Bool(true))
    default:
        #expect(Bool(false), "Loading view should have loading status")
    }

    // Test loaded state
    let loadedView = GalleryView(title: title, status: .loaded, movies: movies)
    switch loadedView.status {
    case .loaded:
        #expect(Bool(true))
    default:
        #expect(Bool(false), "Loaded view should have loaded status")
    }

    // Test failure state
    let error = NSError(domain: "Test", code: 1, userInfo: nil)
    let failureView = GalleryView(title: title, status: .failure(error), movies: movies)
    switch failureView.status {
    case .failure:
        #expect(Bool(true))
    default:
        #expect(Bool(false), "Failure view should have failure status")
    }
}

// MARK: - Movie Collection Tests
@Test("GalleryView should preserve movie order")
@MainActor
func testGalleryViewMovieOrder() {
    // Given
    let title = "Test Gallery"
    let movies = [
        GalleryView.Movie(title: "First Movie", posterURL: nil),
        GalleryView.Movie(title: "Second Movie", posterURL: nil),
        GalleryView.Movie(title: "Third Movie", posterURL: nil),
    ]

    // When
    let galleryView = GalleryView(title: title, status: .loaded, movies: movies)

    // Then
    #expect(galleryView.movies.count == 3)
    #expect(galleryView.movies[0].title == "First Movie")
    #expect(galleryView.movies[1].title == "Second Movie")
    #expect(galleryView.movies[2].title == "Third Movie")
}

@Test("GalleryView should handle single movie")
@MainActor
func testGalleryViewSingleMovie() {
    // Given
    let title = "Single Movie Gallery"
    let movie = GalleryView.Movie(
        title: "Solo Movie", posterURL: URL(string: "https://example.com/solo.jpg"))
    let movies = [movie]

    // When
    let galleryView = GalleryView(title: title, status: .loaded, movies: movies)

    // Then
    #expect(galleryView.movies.count == 1)
    #expect(galleryView.movies.first?.title == "Solo Movie")
    #expect(galleryView.movies.first?.posterURL?.absoluteString == "https://example.com/solo.jpg")
}
