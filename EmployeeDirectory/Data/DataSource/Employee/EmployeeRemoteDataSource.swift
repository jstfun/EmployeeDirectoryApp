//
//  EmployeeRemoteDataSource.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct EmployeeRemoteDataSource: EmployeeDataSource {
    private let apiClient: APIClient
    
    init(_ apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getAll() async throws -> [EmployeeEntity]? {
        let response = await apiClient.getEmployees()
        return try response.get().employees
    }
}
