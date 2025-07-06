import Foundation

// MARK: - MovieCreditsResponse
struct MovieDetailCreditsResponse: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

// MARK: - Crew
struct Crew: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath, creditID, department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department, job
    }
}

// MARK: - Extensions
extension Cast {
    func profileURL() -> URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }
}

extension Crew {
    func profileURL() -> URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
    }
}

extension MovieDetailCreditsResponse {
    var mainCast: [Cast] {
        return cast?.prefix(10).compactMap { $0 } ?? []
    }

    var director: Crew? {
        return crew?.first { $0.job == "Director" }
    }

    var writers: [Crew] {
        return crew?.filter { $0.job == "Writer" || $0.job == "Screenplay" || $0.job == "Story" }
            ?? []
    }

    var producers: [Crew] {
        return crew?.filter { $0.job == "Producer" || $0.job == "Executive Producer" } ?? []
    }
}
