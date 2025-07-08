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
        posterPath: "/test.jpg",
        backdropPath: "/backdrop.jpg",
        voteAverage: 8.5,
        voteCount: 1500,
        popularity: 95.2,
        adult: false,
        originalLanguage: "en",
        originalTitle: "Test Movie",
        genreIds: [28, 12]
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
        posterPath: nil,
        backdropPath: nil,
        voteAverage: 7.0,
        voteCount: 100,
        popularity: 50.0,
        adult: false,
        originalLanguage: "en",
        originalTitle: "Test Movie",
        genreIds: [18]
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
            posterPath: "/test1.jpg", backdropPath: "/backdrop1.jpg", voteAverage: 8.0,
            voteCount: 1000, popularity: 80.0, adult: false, originalLanguage: "en",
            originalTitle: "Test Movie 1", genreIds: [28]),
        Movie(
            id: 2, title: "Test Movie 2", overview: "Test Overview 2", releaseDate: "2023-01-02",
            posterPath: "/test2.jpg", backdropPath: "/backdrop2.jpg", voteAverage: 7.5,
            voteCount: 800, popularity: 70.0, adult: false, originalLanguage: "en",
            originalTitle: "Test Movie 2", genreIds: [35]),
    ]

    // When
    let response = MovieResponse(results: movies, page: 1, totalPages: 10, totalResults: 100)

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
        posterPath: "/test.jpg",
        backdropPath: "/backdrop.jpg",
        voteAverage: 8.5,
        voteCount: 1500,
        popularity: 95.2,
        adult: false,
        originalLanguage: "en",
        originalTitle: "Test Movie",
        genreIds: [28, 12]
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
        posterPath: nil,
        backdropPath: nil,
        voteAverage: 7.0,
        voteCount: 100,
        popularity: 50.0,
        adult: false,
        originalLanguage: "en",
        originalTitle: "Test Movie",
        genreIds: [18]
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
            "poster_path": "/test.jpg",
            "backdrop_path": "/backdrop.jpg",
            "vote_average": 8.5,
            "vote_count": 1500,
            "popularity": 95.2,
            "adult": false,
            "original_language": "en",
            "original_title": "Test Movie",
            "genre_ids": [28, 12]
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
                    "poster_path": "/test1.jpg",
                    "backdrop_path": "/backdrop1.jpg",
                    "vote_average": 8.0,
                    "vote_count": 1000,
                    "popularity": 80.0,
                    "adult": false,
                    "original_language": "en",
                    "original_title": "Test Movie 1",
                    "genre_ids": [28]
                },
                {
                    "id": 2,
                    "title": "Test Movie 2",
                    "overview": "Test Overview 2",
                    "release_date": "2023-01-02",
                    "poster_path": "/test2.jpg",
                    "backdrop_path": "/backdrop2.jpg",
                    "vote_average": 7.5,
                    "vote_count": 800,
                    "popularity": 70.0,
                    "adult": false,
                    "original_language": "en",
                    "original_title": "Test Movie 2",
                    "genre_ids": [35]
                }
            ],
            "page": 1,
            "total_pages": 5,
            "total_results": 100
        }
        """

    let data = json.data(using: .utf8)!

    // When
    let response = try JSONDecoder().decode(MovieResponse.self, from: data)

    // Then
    #expect(response.results.count == 2)
    #expect(response.results.first?.title == "Test Movie 1")
    #expect(response.results.last?.title == "Test Movie 2")
    #expect(response.page == 1)
    #expect(response.totalPages == 5)
    #expect(response.totalResults == 100)
}
