import SwiftUI

struct FavoritesActionsView: View {
    let onShareList: () -> Void
    let onClearAll: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ações Rápidas")
                .font(.headline)
                .padding(.horizontal)

            VStack(spacing: 8) {
                quickActionButton(
                    icon: "square.and.arrow.up",
                    title: "Compartilhar Lista",
                    action: onShareList
                )

                quickActionButton(
                    icon: "trash",
                    title: "Limpar Favoritos",
                    action: onClearAll,
                    isDestructive: true
                )
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private func quickActionButton(
        icon: String,
        title: String,
        action: @escaping () -> Void,
        isDestructive: Bool = false
    ) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isDestructive ? .red : .blue)

                Text(title)
                    .font(.subheadline)
                    .foregroundColor(isDestructive ? .red : .primary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FavoritesActionsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesActionsView(onShareList: {}, onClearAll: {})
    }
}
