import SwiftUI

struct FavoriteMovieCard: View {
    let movie: FavoriteMovie
    let onRemove: (FavoriteMovie) -> Void

    var body: some View {
        NavigationLink(value: movie) {
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        VStack {
                            if let coverImageUrl = movie.coverImageUrl,
                                let url = URL(string: coverImageUrl)
                            {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    VStack {
                                        Image(systemName: "film")
                                            .font(.system(size: 40))
                                            .foregroundColor(.white)

                                        Text(movie.title)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 4)
                                    }
                                }
                            } else {
                                VStack {
                                    Image(systemName: "film")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)

                                    Text(movie.title)
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 4)
                                }
                            }
                        }
                    )
                    .cornerRadius(12)
                    .overlay(
                        Button(action: {
                            onRemove(movie)
                        }) {
                            Image(systemName: "heart.fill")
                                .font(.title3)
                                .foregroundColor(.red)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 30, height: 30)
                                )
                        }
                        .padding(8),
                        alignment: .topTrailing
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    HStack {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)

                        Text("4.5")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Spacer()

                        Text("2023")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
            }
            .background(Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FavoriteMovieCard_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMovieCard(movie: FavoriteMovie(id: 1, title: "Filme Exemplo", coverImageUrl: nil)) {
            _ in
        }
        .frame(width: 180)
    }
}
