import Foundation

enum ServiceError: Error, LocalizedError, Equatable {
    case invalidUrl
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    case invalidParameters
}
