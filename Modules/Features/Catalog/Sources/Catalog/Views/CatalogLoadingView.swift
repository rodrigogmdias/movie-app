import Components
import SwiftUI

struct CatalogLoadingView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Bem vindo ao Movie App! 👋")
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
                    HStack {
                        SkeletonView()
                            .frame(width: 180, height: 20)
                        Spacer()
                        SkeletonView()
                            .frame(width: 60, height: 20)
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<5, id: \.self) { _ in
                                VStack(alignment: .leading, spacing: 8) {
                                    SkeletonView()
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(8)

                                    SkeletonView()
                                        .frame(width: 100, height: 14)

                                    SkeletonView()
                                        .frame(width: 80, height: 12)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    SkeletonView()
                        .frame(width: 80, height: 20)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<5, id: \.self) { _ in
                                SkeletonView()
                                    .frame(width: 100, height: 35)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    SkeletonView()
                        .frame(width: 120, height: 20)
                        .padding(.horizontal)

                    ForEach(0..<5, id: \.self) { _ in
                        HStack {
                            SkeletonView()
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)

                            VStack(alignment: .leading, spacing: 4) {
                                SkeletonView()
                                    .frame(width: 150, height: 16)

                                SkeletonView()
                                    .frame(width: 200, height: 12)

                                SkeletonView()
                                    .frame(width: 120, height: 12)
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

#Preview {
    CatalogLoadingView()
}
