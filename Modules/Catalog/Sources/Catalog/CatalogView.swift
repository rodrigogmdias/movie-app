import SwiftUI

protocol CatalogInteracting {
    // Define methods for interaction with the catalog
}

public struct CatalogView: View {
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bem vindo ao MovieIA! 👋")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("Vamos explorar o catálogo de filmes?")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "film")
                                .foregroundColor(.white)
                        )
                }
                .padding(.horizontal)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Buscar filmes...", text: .constant(""))
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Filmes em destaque")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<10, id: \.self) { index in
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 120, height: 180)
                                        .overlay(
                                            Text("Filme \(index + 1)")
                                                .foregroundColor(.white)
                                                .font(.caption)
                                                .padding(4),
                                            alignment: .bottom
                                        )
                                }
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Categorias")
                        .font(.headline)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(
                                ["Ação", "Comédia", "Drama", "Terror", "Ficção Científica"],
                                id: \.self
                            ) { category in
                                Text(category)
                                    .padding(10)
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(8)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Mais vistos")
                        .font(.headline)
                        .padding(.horizontal)

                    ForEach(0..<5, id: \.self) { index in
                        HStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Filme \(index + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)

                                Text("Descrição breve do filme.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
