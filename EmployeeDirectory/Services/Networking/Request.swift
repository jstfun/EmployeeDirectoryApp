//
//  Request.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

struct HTTPHeader {
    let field: HTTPHeaderField
    let value: String
}

protocol Request {
    associatedtype ResponseType: Codable
    
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [HTTPHeader]? { get }
    var queries: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Request {
    func toURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        if method == .get, let queries = queries {
            urlComponents.queryItems = queries.map { URLQueryItem(name: $0, value: $1) }
        }
        guard let finalURL = urlComponents.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: finalURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        if let headers = headers {
            headers.forEach {
                urlRequest.addValue($0.value, forHTTPHeaderField: $0.field.rawValue)
            }
        }
        if method == .post, let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        return urlRequest
    }
}
