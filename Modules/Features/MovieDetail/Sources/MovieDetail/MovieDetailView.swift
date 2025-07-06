import SwiftUI

public struct MovieDetailView: View {
    private let title: String
    private let coverImageUrl: URL?
    private let synopsis: String
    private let rating: Double
    private let duration: String
    private let genres: [String]
    private let releaseDate: String
    private let director: String
    private let cast: [String]

    @Environment(\.presentationMode) var presentationMode

    public init(
        title: String,
        coverImageUrl: URL? = nil,
        synopsis: String =
            "Uma história envolvente que cativa o público com sua narrativa única e personagens memoráveis.",
        rating: Double = 8.5,
        duration: String = "2h 30min",
        genres: [String] = ["Drama", "Crime"],
        releaseDate: String = "1994",
        director: String = "Frank Darabont",
        cast: [String] = ["Tim Robbins", "Morgan Freeman", "Bob Gunton"]
    ) {
        self.title = title
        self.coverImageUrl = coverImageUrl
        self.synopsis = synopsis
        self.rating = rating
        self.duration = duration
        self.genres = genres
        self.releaseDate = releaseDate
        self.director = director
        self.cast = cast
    }

    private func handleBackAction() {
        presentationMode.wrappedValue.dismiss()
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    GeometryReader { geometry in
                        let offset = geometry.frame(in: .named("scrollView")).minY
                        let height: CGFloat = 400

                        if let coverImageUrl = coverImageUrl {
                            AsyncImage(url: coverImageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: geometry.size.width,
                                        height: height + max(0, offset)
                                    )
                                    .clipped()
                                    .offset(y: offset > 0 ? -offset : 0)
                            } placeholder: {
                                Color.gray
                                    .frame(
                                        width: geometry.size.width,
                                        height: height + max(0, offset)
                                    )
                                    .offset(y: offset > 0 ? -offset : 0)
                            }
                        } else {
                            Color.gray
                                .frame(
                                    width: geometry.size.width,
                                    height: height + max(0, offset)
                                )
                                .offset(y: offset > 0 ? -offset : 0)
                        }
                    }
                    .frame(height: 400)

                    VStack(alignment: .leading, spacing: 16) {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top)

                        HStack(spacing: 20) {
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", rating))
                                    .fontWeight(.semibold)
                            }

                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .foregroundColor(.blue)
                                Text(duration)
                            }

                            HStack(spacing: 4) {
                                Image(systemName: "calendar")
                                    .foregroundColor(.green)
                                Text(releaseDate)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(genres, id: \.self) { genre in
                                    Text(genre)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(16)
                                }
                            }
                            .padding(.horizontal)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("📖 Sinopse")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Spacer()
                            }

                            Text(synopsis)
                                .font(.body)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("🎬 Diretor")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Spacer()
                            }

                            Text(director)
                                .font(.body)
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("🎭 Elenco Principal")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                Spacer()
                            }

                            ForEach(cast, id: \.self) { actor in
                                Text("• \(actor)")
                                    .font(.body)
                            }
                        }
                        .padding(.horizontal)

                        HStack(spacing: 16) {
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text("Assistir")
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                            }

                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "heart")
                                    Text("Favoritar")
                                }
                                .font(.headline)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                    }
                }
            }
            .coordinateSpace(name: "scrollView")

            Button(action: handleBackAction) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Voltar")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.6))
                        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 2)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
            }
            .padding(.top, 50)
            .padding(.leading, 20)
        }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        #if os(iOS) || os(watchOS) || os(tvOS)
            .navigationBarHidden(true)
        #endif
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 100 && abs(value.translation.height) < 50 {
                        handleBackAction()
                    }
                }
        )
    }

}

#Preview {
    MovieDetailView(
        title: "The Shawshank Redemption",
        coverImageUrl: URL(
            string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"),
        synopsis:
            "Dois homens presos se unem ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum. Uma história tocante sobre amizade, esperança e a capacidade humana de encontrar luz mesmo nas circunstâncias mais sombrias.",
        rating: 9.3,
        duration: "2h 22min",
        genres: ["Drama", "Crime"],
        releaseDate: "1994",
        director: "Frank Darabont",
        cast: ["Tim Robbins", "Morgan Freeman", "Bob Gunton", "James Whitmore"]
    )
}
