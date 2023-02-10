//
//  ImageRemoteDataSource.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct ImageRemoteDataSource: ImageDataSource {
    private let apiClient: APIClient
    
    init(_ apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func get(for url: URL) async -> AnyObject? {
        do {
            return try await apiClient.fetch(from: url)
        } catch {
            return nil
        }
    }
    
    func update(for url: URL, data: AnyObject) throws {}
}
