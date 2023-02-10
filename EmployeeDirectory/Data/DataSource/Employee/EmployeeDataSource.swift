//
//  EmployeeDataSource.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

protocol EmployeeDataSource {
    func getAll() async throws -> [EmployeeEntity]?
}
