import Foundation

public struct FavoriteMovie: Codable, Identifiable, Equatable, Hashable {
    public let id: Int
    public let title: String
    public let coverImageUrl: String?

    public init(id: Int, title: String, coverImageUrl: String?) {
        self.id = id
        self.title = title
        self.coverImageUrl = coverImageUrl
    }
}
