import Foundation

struct ApiService {
    
    typealias UserInformationHandler = (Result<CVInformation.CodingData, LoadingError>) -> Void
    
    func loadInformation(then handler: @escaping UserInformationHandler) {
        let request = ApiRequest(resource: CVResource())
        request.load(then: handler)
    }
}
