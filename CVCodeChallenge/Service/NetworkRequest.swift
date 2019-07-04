import Foundation

protocol NetworkRequest {
    associatedtype LoadedType
    func load(then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken
    func decode(_ data: Data) throws -> LoadedType
}

extension NetworkRequest {
    
    @discardableResult
    func load(url: URL, then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                handler(Result.failure(.loadFail))
                return
            }
            guard let data = data else {
                handler(Result.failure(.nilData))
                return
            }
            do {
                let loadedType = try self.decode(data)
                handler(Result.success(loadedType))
            } catch {
                handler(Result.failure(.decodeFail))
            }
        }
        task.resume()
        return RequestToken(task: task)
    }
}
