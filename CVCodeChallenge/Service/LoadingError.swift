import Foundation

enum LoadingError: Error {
    case loadFail
    case nilData
    case decodeFail
    case badURL
}
