import Components
import SwiftUI

protocol MovieDetailInteracting {
    func handleOnLoad(request: MovieDetail.OnLoad.Request) async
}

public struct MovieDetailView: View {
    private let interactor: MovieDetailInteracting?
    @ObservedObject var viewState: ViewState = .init()

    private let title: String
    private let coverImageUrl: URL?

    @Environment(\.presentationMode) var presentationMode

    init(
        title: String,
        coverImageUrl: URL? = nil,
        interactor: MovieDetailInteracting? = nil
    ) {
        self.title = title
        self.coverImageUrl = coverImageUrl
        self.interactor = interactor
    }

    private func handleBackAction() {
        presentationMode.wrappedValue.dismiss()
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            if viewState.isLoading {
                MovieDetailLoadingView(
                    title: title,
                    coverImageUrl: coverImageUrl
                )
            } else {
                MovieDetailLoadedView(
                    title: title,
                    coverImageUrl: coverImageUrl,
                    viewState: viewState
                )
            }

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
        .onAppear {
            let currentInteractor = interactor
            Task {
                await currentInteractor?.handleOnLoad(request: MovieDetail.OnLoad.Request())
            }
        }
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

    public class ViewState: ObservableObject, MovieDetailDisplaying {
        @Published var isLoading: Bool = true
        @Published var synopsis: String?
        @Published var rating: Double?
        @Published var duration: String?
        @Published var genres: [String]?
        @Published var releaseDate: String?
        @Published var director: String?
        @Published var cast: [MovieDetail.OnLoad.CastMember]?

        func displayOnLoad(viewModel: MovieDetail.OnLoad.ViewModel) {
            synopsis = viewModel.synopsis
            rating = viewModel.rating
            duration = viewModel.duration
            genres = viewModel.genres
            releaseDate = viewModel.releaseDate
            director = viewModel.director
            cast = viewModel.cast
            isLoading = false
        }
    }
}

#Preview {
    MovieDetailView(
        title: "The Shawshank Redemption",
        coverImageUrl: URL(
            string: "https://image.tmdb.org/t/p/w500/m5NKltgQqqyoWJNuK18IqEGRG7J.jpg")
    )
}
