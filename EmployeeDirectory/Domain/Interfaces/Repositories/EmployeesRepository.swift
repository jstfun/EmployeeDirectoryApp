//
//  EmployeesRepository.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

protocol EmployeesRepository {
    // Employees from a local data source
    func get() async -> [EmployeeModel]?
    // Employees from a remote data source
    func fetch() async throws -> [EmployeeModel]
}
