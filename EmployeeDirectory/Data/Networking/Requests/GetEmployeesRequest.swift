//
//  GetEmployeesRequest.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct GetEmployeesRequest: Request {
    typealias ResponseType = EmployeesDTO
    
    var method: HTTPMethod = .get
    
    var path: String = "/employees.json"
    
    var headers: [HTTPHeader]?
    
    var queries: [String : String]?
    
    var body: [String: Any]?
}
