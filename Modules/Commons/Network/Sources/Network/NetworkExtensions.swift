extension Result where Success: Decodable, Failure == NetworkError {
    func handleResult(
        onSuccess: (Success) -> Void,
        onFailure: (NetworkError) -> Void
    ) {
        switch self {
        case .success(let data):
            onSuccess(data)
        case .failure(let error):
            onFailure(error)
        }
    }
}
