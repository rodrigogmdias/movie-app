import SwiftUI
import Testing

@testable import Components

// MARK: - GalleryView.Movie Tests
@Test("Movie model should be created with correct properties")
func testMovieModelCreation() {
    // Given
    let id = 1
    let title = "Test Movie"
    let posterURL = URL(string: "https://example.com/poster.jpg")

    // When
    let movie = GalleryView.Movie(id: id, title: title, posterURL: posterURL)

    // Then
    #expect(movie.id == id)
    #expect(movie.title == title)
    #expect(movie.posterURL == posterURL)
}

@Test("Movie model should handle nil posterURL")
func testMovieModelWithNilPosterURL() {
    // Given
    let id = 1
    let title = "Test Movie"

    // When
    let movie = GalleryView.Movie(id: id, title: title, posterURL: nil)

    // Then
    #expect(movie.id == id)
    #expect(movie.title == title)
    #expect(movie.posterURL == nil)
}

@Test("Movie model should conform to Identifiable")
func testMovieModelIdentifiable() {
    // Given
    let movie1 = GalleryView.Movie(id: 1, title: "Movie 1", posterURL: nil)
    let movie2 = GalleryView.Movie(id: 2, title: "Movie 2", posterURL: nil)

    // Then
    #expect(movie1.id != movie2.id)  // Each movie should have a unique ID
}

// MARK: - GalleryStatus Tests
@Test("GalleryStatus should support loading state")
func testGalleryStatusLoading() {
    // Given
    let status = GalleryView.GalleryStatus.loading

    // When/Then
    switch status {
    case .loading:
        break  // Expected case
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
        break  // Expected case
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

// TODO: Add meaningful tests for GalleryView behavior once properties are accessible
