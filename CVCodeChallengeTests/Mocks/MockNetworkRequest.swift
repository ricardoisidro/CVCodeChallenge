import Foundation

protocol NetworkRequestMocking {
    func load(then handler: @escaping (Result<Data, LoadingError>) -> Void) -> RequestToken
    func decode(_ data: Data) throws -> CVInformation?
}

class MockNetworkRequest: NetworkRequestMocking {
    
    var localURLString: String?
    
    func load(then handler: @escaping (Result<Data, LoadingError>) -> Void) -> RequestToken {
        guard let localURL = Bundle.main.url(forResource: localURLString, withExtension: "json") else {
            handler(.failure(.badURL))
            return RequestToken(task: URLSessionDataTask())
        }
        
        if let data = try? Data(contentsOf: localURL) {
            handler(.success(data))
            return RequestToken(task: URLSessionDataTask())
        } else {
            handler(.failure(.loadFail))
            return RequestToken(task: URLSessionDataTask())
        }
    }
    
    func decode(_ data: Data) throws -> CVInformation? {
        let decoder = JSONDecoder()
        if let json = try? decoder.decode(CVInformation.self, from: data) {
            return json
        } else {
            return nil
        }
    }
}
