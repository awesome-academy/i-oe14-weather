//
//  BaseError.swift
//  Weather
//
//  Created by minh duc on 2/18/19.
//  Copyright © 2019 minhduc. All rights reserved.
//

enum BaseError {
    case networkError
    case httpError(code: Int)
    case unexpectedError(error: Error?)
    case apiFailure(error: ErrorResponse)
    
    var errorMessage: String? {
        switch self {
        case .apiFailure(let error):
            return error.weatherError
        case .networkError:
            return Constants.networkError
        case .httpError(let code):
            return getHttpErrorMessage(httpCode: code)
        case .unexpectedError(let error):
            return error?.localizedDescription ?? Constants.unofficialError
        }
    }
    
    private func getHttpErrorMessage(httpCode: Int) -> String? {
        switch httpCode {
        case 300...308:
            return Constants.redirectionError // Redirection
        case 400...499:
            return Constants.clientError // Client error
        case 500...511:
            return Constants.serverError // Server error
        default:
            return Constants.unofficialError // Unofficial error
        }
    }
}
