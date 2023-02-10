//
//  GetEmployeesUseCase.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct GetEmployeesUseCase {
    
    private let employeeRepository: EmployeesRepository
    
    init(employeeRepository: EmployeesRepository = EmployeeRepositoryImp()) {
        self.employeeRepository = employeeRepository
    }
    
    func execute() async throws -> [EmployeeModel] {
        var employees = [EmployeeModel]()
        
        do {
            let remoteEmployees = try await employeeRepository.fetch()
            employees = remoteEmployees
        } catch {
            throw UseCaseError.failedGetEmployees
        }
        
        return employees
    }
}
