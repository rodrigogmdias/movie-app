import Foundation
import Testing

@testable import Catalog

@Test func testMovieInitialization() async throws {
    // Given & When
    let movie = Movie(
        id: 1,
        title: "Test Movie",
        overview: "Test Overview",
        releaseDate: "2023-01-01",
        posterPath: "/test.jpg"
    )

    // Then
    #expect(movie.id == 1)
    #expect(movie.title == "Test Movie")
    #expect(movie.overview == "Test Overview")
    #expect(movie.releaseDate == "2023-01-01")
    #expect(movie.posterPath == "/test.jpg")
}

@Test func testMovieInitializationWithNilPosterPath() async throws {
    // Given & When
    let movie = Movie(
        id: 1,
        title: "Test Movie",
        overview: "Test Overview",
        releaseDate: "2023-01-01",
        posterPath: nil
    )

    // Then
    #expect(movie.id == 1)
    #expect(movie.title == "Test Movie")
    #expect(movie.overview == "Test Overview")
    #expect(movie.releaseDate == "2023-01-01")
    #expect(movie.posterPath == nil)
}

@Test func testMovieResponseInitialization() async throws {
    // Given
    let movies = [
        Movie(
            id: 1, title: "Test Movie 1", overview: "Test Overview 1", releaseDate: "2023-01-01",
            posterPath: "/test1.jpg"),
        Movie(
            id: 2, title: "Test Movie 2", overview: "Test Overview 2", releaseDate: "2023-01-02",
            posterPath: "/test2.jpg"),
    ]

    // When
    let response = MovieResponse(results: movies)

    // Then
    #expect(response.results.count == 2)
    #expect(response.results.first?.title == "Test Movie 1")
    #expect(response.results.last?.title == "Test Movie 2")
}

@Test func testMoviePosterURLWithValidPath() async throws {
    // Given
    let movie = Movie(
        id: 1,
        title: "Test Movie",
        overview: "Test Overview",
        releaseDate: "2023-01-01",
        posterPath: "/test.jpg"
    )

    // When
    let posterURL = movie.posterURL()

    // Then
    #expect(posterURL != nil)
    #expect(posterURL?.absoluteString == "https://image.tmdb.org/t/p/w500/test.jpg")
}

@Test func testMoviePosterURLWithNilPath() async throws {
    // Given
    let movie = Movie(
        id: 1,
        title: "Test Movie",
        overview: "Test Overview",
        releaseDate: "2023-01-01",
        posterPath: nil
    )

    // When
    let posterURL = movie.posterURL()

    // Then
    #expect(posterURL == nil)
}

@Test func testMovieDecodingFromJSON() async throws {
    // Given
    let json = """
        {
            "id": 1,
            "title": "Test Movie",
            "overview": "Test Overview",
            "release_date": "2023-01-01",
            "poster_path": "/test.jpg"
        }
        """

    let data = json.data(using: .utf8)!

    // When
    let movie = try JSONDecoder().decode(Movie.self, from: data)

    // Then
    #expect(movie.id == 1)
    #expect(movie.title == "Test Movie")
    #expect(movie.overview == "Test Overview")
    #expect(movie.releaseDate == "2023-01-01")
    #expect(movie.posterPath == "/test.jpg")
}

@Test func testMovieResponseDecodingFromJSON() async throws {
    // Given
    let json = """
        {
            "results": [
                {
                    "id": 1,
                    "title": "Test Movie 1",
                    "overview": "Test Overview 1",
                    "release_date": "2023-01-01",
                    "poster_path": "/test1.jpg"
                },
                {
                    "id": 2,
                    "title": "Test Movie 2",
                    "overview": "Test Overview 2",
                    "release_date": "2023-01-02",
                    "poster_path": "/test2.jpg"
                }
            ]
        }
        """

    let data = json.data(using: .utf8)!

    // When
    let response = try JSONDecoder().decode(MovieResponse.self, from: data)

    // Then
    #expect(response.results.count == 2)
    #expect(response.results.first?.title == "Test Movie 1")
    #expect(response.results.last?.title == "Test Movie 2")
}
