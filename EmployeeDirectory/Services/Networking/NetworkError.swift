//
//  NetworkError.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidRequest
    case invalidData
    case invalidResponse
    case invalidHttpStatus(Int)
    case decodingError
    case dispatchError
    case unknown
}
