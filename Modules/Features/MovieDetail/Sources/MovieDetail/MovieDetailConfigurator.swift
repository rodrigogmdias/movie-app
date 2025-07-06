import Foundation

public struct MovieDetailConfigurator {
    @MainActor public static func configure(title: String, coverImageUrl: URL?) -> MovieDetailView {
        let view = MovieDetailView(title: title, coverImageUrl: coverImageUrl)
        return view
    }
}
