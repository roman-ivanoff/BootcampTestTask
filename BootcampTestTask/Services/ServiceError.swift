import Foundation

enum ServiceError: Error, LocalizedError {
    case invalidUrl
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    case invalidParameters
}
