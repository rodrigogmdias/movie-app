import CachedAsyncImage
import SwiftUI

struct HeaderCoverImageView: View {
    let coverImageUrl: URL?
    
    var body: some View {
        return GeometryReader { geometry in
            let offset = geometry.frame(in: .named("scrollView")).minY
            let height: CGFloat = 400
            
            if let coverImageUrl = coverImageUrl {
                CachedAsyncImage(url: coverImageUrl) { image in
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
    }
}

#Preview {
    HeaderCoverImageView(
        coverImageUrl: URL(
            string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg"
        )
    )
}
