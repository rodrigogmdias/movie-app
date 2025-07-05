//
//  MovieResponse.swift
//  Catalog
//
//  Created by Rodrigo Dias on 05/07/25.
//
import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

extension Movie {
    func posterURL() -> URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}
