//
//  HTTPClient.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

final class URLContent {
    let data: Data
    let response: URLResponse
    
    init(data: Data, response: URLResponse) {
        self.data = data
        self.response = response
    }
}

protocol HTTPClient {
    func dispatch(request: URLRequest) async throws -> URLContent
}

class URLSessionHTTPClient: HTTPClient {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func dispatch(request: URLRequest) async throws -> URLContent {
        let (data, response) = try await urlSession.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.invalidHttpStatus(httpResponse.statusCode)
        }
        
        return URLContent(data: data, response: response)
    }
}
