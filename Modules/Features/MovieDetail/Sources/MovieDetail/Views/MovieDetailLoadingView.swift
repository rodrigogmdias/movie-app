import Components
import SwiftUI

struct MovieDetailLoadingView: View {
    let title: String
    let coverImageUrl: URL?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top, 20)
            
            HStack(spacing: 20) {
                SkeletonView()
                    .frame(width: 60, height: 20)
                SkeletonView()
                    .frame(width: 80, height: 20)
                SkeletonView()
                    .frame(width: 70, height: 20)
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<3, id: \.self) { _ in
                        SkeletonView()
                            .frame(width: 80, height: 28)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                SkeletonView()
                    .frame(width: 100, height: 20)
                
                VStack(spacing: 8) {
                    SkeletonView()
                        .frame(height: 16)
                    SkeletonView()
                        .frame(height: 16)
                    SkeletonView()
                        .frame(width: 200, height: 16)
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 12) {
                SkeletonView()
                    .frame(width: 150, height: 20)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0..<4, id: \.self) { _ in
                            VStack(spacing: 10) {
                                SkeletonView()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                
                                VStack(spacing: 4) {
                                    SkeletonView()
                                        .frame(width: 60, height: 12)
                                    SkeletonView()
                                        .frame(width: 50, height: 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                SkeletonView()
                    .frame(width: 180, height: 20)
                
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(0..<4, id: \.self) { _ in
                        HStack {
                            SkeletonView()
                                .frame(width: 80, height: 16)
                            Spacer()
                            SkeletonView()
                                .frame(width: 60, height: 16)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding(.horizontal)
            
            HStack(spacing: 16) {
                SkeletonView()
                    .frame(height: 50)
                    .cornerRadius(8)
                
                SkeletonView()
                    .frame(height: 50)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    MovieDetailLoadingView(
        title: "The Shawshank Redemption",
        coverImageUrl: URL(string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg")
    )
}
