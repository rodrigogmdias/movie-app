import SwiftUI

struct FavoritesHeaderView: View {
    let favoritesCount: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Seus Favoritos ❤️")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("\(favoritesCount) filmes salvos")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
                // Ação futura para editar
            }) {
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .animation(.easeInOut(duration: 0.3), value: favoritesCount)
    }
}

struct FavoritesHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesHeaderView(favoritesCount: 5)
    }
}
