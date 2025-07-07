import SwiftUI

struct FavoritesEmptyView: View {
    @State private var hasAppeared = false

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)

            Text("Nenhum filme favorito ainda")
                .font(.headline)
                .foregroundColor(.primary)

            Text("Explore o catálogo e adicione seus filmes favoritos aqui!")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            Button(action: {
                NotificationCenter.default.post(
                    name: NSNotification.Name("GoToHome"), object: nil)
            }) {
                Text("Explorar Catálogo")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical, 60)
        .transition(
            hasAppeared
                ? .asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ) : .identity
        )
        .onAppear {
            hasAppeared = true
        }
    }
}

struct FavoritesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesEmptyView()
    }
}
