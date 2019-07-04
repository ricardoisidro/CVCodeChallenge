import Foundation

protocol ApiResource {
    associatedtype Model
    var url: URL { get }
    func makeModel(fromData data: Data) throws -> Model
}
