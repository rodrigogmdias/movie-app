import Foundation

public enum MovieDetail {
    public enum OnLoad {
        public struct Request {
        }

        struct Response {
            let movie: MovieDetailResponse
            let credits: MovieDetailCreditsResponse
        }

        struct ViewModel {
            let synopsis: String?
            let rating: Double?
            let duration: String?
            let genres: [String]?
            let releaseDate: String?
            let director: String?
            let cast: [CastMember]?
        }

        struct CastMember: Identifiable {
            let id: Int
            let name: String
            let character: String?
            let profileURL: URL?
        }
    }
}
