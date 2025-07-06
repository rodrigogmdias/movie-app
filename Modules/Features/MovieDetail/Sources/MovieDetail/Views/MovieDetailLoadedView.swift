import SwiftUI

struct MovieDetailLoadedView: View {
    let title: String
    let coverImageUrl: URL?
    let viewState: MovieDetailView.ViewState

    var body: some View {
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

                VStack(alignment: .leading, spacing: 20) {
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    HStack(spacing: 20) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", viewState.rating ?? 0))
                                .fontWeight(.semibold)
                        }

                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                            Text(viewState.duration ?? "")
                        }

                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .foregroundColor(.green)
                            Text(viewState.releaseDate ?? "")
                        }

                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(viewState.genres ?? [], id: \.self) { genre in
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

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("📖 Sinopse")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                        }

                        Text(viewState.synopsis ?? "Sinopse não disponível.")
                            .font(.body)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("🎭 Elenco Principal")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(viewState.cast ?? [], id: \.id) { actor in
                                    VStack(spacing: 10) {
                                        if let profileURL = actor.profileURL {
                                            AsyncImage(url: profileURL) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(Circle())
                                                    .overlay(
                                                        Circle()
                                                            .stroke(
                                                                Color.blue.opacity(0.3),
                                                                lineWidth: 2)
                                                    )
                                            } placeholder: {
                                                Circle()
                                                    .fill(Color.gray.opacity(0.3))
                                                    .frame(width: 80, height: 80)
                                                    .overlay(
                                                        Image(systemName: "person.fill")
                                                            .foregroundColor(.gray)
                                                            .font(.system(size: 30))
                                                    )
                                            }
                                        } else {
                                            Circle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 80, height: 80)
                                                .overlay(
                                                    Image(systemName: "person.fill")
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 30))
                                                )
                                        }

                                        VStack(spacing: 4) {
                                            Text(actor.name)
                                                .font(.caption)
                                                .fontWeight(.medium)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.center)

                                            if let character = actor.character {
                                                Text(character)
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)
                                                    .lineLimit(2)
                                                    .multilineTextAlignment(.center)
                                            }
                                        }
                                        .frame(width: 80)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("📊 Informações Técnicas")
                                .font(.headline)
                                .fontWeight(.semibold)
                            Spacer()
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Avaliação:")
                                    .fontWeight(.medium)
                                Spacer()
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(String(format: "%.1f/10", viewState.rating ?? 0))
                                        .fontWeight(.semibold)
                                }
                            }

                            HStack {
                                Text("Duração:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(viewState.duration ?? "N/A")
                            }

                            HStack {
                                Text("Lançamento:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(viewState.releaseDate ?? "N/A")
                            }

                            HStack {
                                Text("Diretor:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text(viewState.director ?? "N/A")
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
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
                            .padding(.vertical, 16)
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
                            .padding(.vertical, 16)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .coordinateSpace(name: "scrollView")
    }
}

#Preview {
    let mockViewState = MovieDetailView.ViewState()
    mockViewState.isLoading = false
    mockViewState.synopsis =
        "Dois homens presos se unem ao longo de vários anos, encontrando consolo e eventual redenção através de atos de decência comum."
    mockViewState.rating = 9.3
    mockViewState.duration = "2h 22m"
    mockViewState.genres = ["Drama", "Crime"]
    mockViewState.releaseDate = "14 de outubro de 1994"
    mockViewState.director = "Frank Darabont"
    mockViewState.cast = [
        MovieDetail.OnLoad.CastMember(
            id: 1,
            name: "Tim Robbins",
            character: "Andy Dufresne",
            profileURL: URL(
                string: "https://image.tmdb.org/t/p/w185/hsCuIGStALaVfMdwSBECMJ6Gre6.jpg")
        ),
        MovieDetail.OnLoad.CastMember(
            id: 2,
            name: "Morgan Freeman",
            character: "Ellis Boyd 'Red' Redding",
            profileURL: URL(
                string: "https://image.tmdb.org/t/p/w185/jPsLqiYGSofU4s6BjrxnefMfabb.jpg")
        ),
    ]

    return MovieDetailLoadedView(
        title: "The Shawshank Redemption",
        coverImageUrl: URL(
            string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"),
        viewState: mockViewState
    )
}
