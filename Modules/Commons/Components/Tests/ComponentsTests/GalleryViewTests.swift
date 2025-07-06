import SwiftUI
import Testing

@testable import Components

@Test("Movie model should be created with correct properties")
func testMovieModelCreation() {
    let id = 1
    let title = "Test Movie"
    let posterURL = URL(string: "https://example.com/poster.jpg")

    let movie = GalleryView.Movie(id: id, title: title, posterURL: posterURL)

    #expect(movie.id == id)
    #expect(movie.title == title)
    #expect(movie.posterURL == posterURL)
}

@Test("Movie model should handle nil posterURL")
func testMovieModelWithNilPosterURL() {
    let id = 1
    let title = "Test Movie"

    let movie = GalleryView.Movie(id: id, title: title, posterURL: nil)

    // Then
    #expect(movie.id == id)
    #expect(movie.title == title)
    #expect(movie.posterURL == nil)
}

@Test("Movie model should conform to Identifiable")
func testMovieModelIdentifiable() {
    let movie1 = GalleryView.Movie(id: 1, title: "Movie 1", posterURL: nil)
    let movie2 = GalleryView.Movie(id: 2, title: "Movie 2", posterURL: nil)

    #expect(movie1.id != movie2.id)
}

@Test("GalleryStatus should support loading state")
func testGalleryStatusLoading() {
    let status = GalleryView.GalleryStatus.loading

    switch status {
    case .loading:
        break
    default:
        #expect(Bool(false), "Status should be loading")
    }
}

@Test("GalleryStatus should support loaded state")
func testGalleryStatusLoaded() {
    let status = GalleryView.GalleryStatus.loaded

    switch status {
    case .loaded:
        break
    default:
        #expect(Bool(false), "Status should be loaded")
    }
}

@Test("GalleryStatus should support failure state with error")
func testGalleryStatusFailure() {
    let error = NSError(
        domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
    let status = GalleryView.GalleryStatus.failure(error)

    switch status {
    case .failure(let receivedError):
        #expect(receivedError.localizedDescription == "Test error")
    default:
        #expect(Bool(false), "Status should be failure")
    }
}
