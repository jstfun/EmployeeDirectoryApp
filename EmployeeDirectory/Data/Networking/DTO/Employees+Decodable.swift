//
//  Employees+Decodable.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct EmployeesDTO: Codable {
    let employees: [EmployeeEntity]
}
