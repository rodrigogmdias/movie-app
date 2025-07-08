import Foundation

@testable import Catalog

extension Movie {
    static func mock(
        id: Int = 1,
        title: String = "Test Movie",
        overview: String = "Test Overview",
        releaseDate: String = "2023-01-01",
        posterPath: String? = "/test.jpg",
        backdropPath: String? = "/backdrop.jpg",
        voteAverage: Double = 8.0,
        voteCount: Int = 1000,
        popularity: Double = 80.0,
        adult: Bool = false,
        originalLanguage: String = "en",
        originalTitle: String = "Test Movie",
        genreIds: [Int] = [28]
    ) -> Movie {
        return Movie(
            id: id,
            title: title,
            overview: overview,
            releaseDate: releaseDate,
            posterPath: posterPath,
            backdropPath: backdropPath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            popularity: popularity,
            adult: adult,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            genreIds: genreIds
        )
    }
}
