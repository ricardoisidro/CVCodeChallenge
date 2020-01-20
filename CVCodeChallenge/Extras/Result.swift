// Ricardo Isidro Ramirez

import Foundation

enum Result<S, F> where F: Error {
    case success(S)
    case failure(F)
}
