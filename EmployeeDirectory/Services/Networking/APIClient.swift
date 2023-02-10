//
//  APIClient.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

class APIClient {
    private let baseURL: String
    private let httpClient: HTTPClient
    private let decoder: JSONDecoder
    
    init(baseURL: String = Constants.API.baseURL,
         httpClient: HTTPClient = URLSessionHTTPClient(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.httpClient = httpClient
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func decodeContent<Response: Decodable>(_ content: URLContent) -> Result<Response, NetworkError> {
        do {
            let decoded = try decoder.decode(Response.self, from: content.data)
            return .success(decoded)
        } catch is DecodingError {
            return .failure(.decodingError)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }
    
    func getEmployees() async -> Result<EmployeesDTO, NetworkError>{
        let request = GetEmployeesRequest()
        
        guard let urlRequest = request.toURLRequest(baseURL: baseURL) else {
            return .failure(.invalidRequest)
        }
        
        do {
            let content = try await httpClient.dispatch(request: urlRequest)
            return decodeContent(content)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.dispatchError)
        }
    }
    
    func fetch(from url: URL) async throws -> URLContent {
        try await httpClient.dispatch(request: URLRequest(url: url))
    }
}
