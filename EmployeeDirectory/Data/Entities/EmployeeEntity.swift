//
//  EmployeeEntity.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

struct EmployeeEntity {
    let uuid: String
    let fullName: String
    var phoneNumber: String?
    let emailAddress: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    let team: String
    let employeeType: String
}

extension EmployeeEntity: Codable {}

extension EmployeeEntity {
    static var exmple: Self {
        EmployeeEntity(uuid: "0d8fcc12-4d0c-425c-8355-390b312b909c",
                       fullName: "Justine Mason",
                       phoneNumber: "5553280567",
                       emailAddress: "jmason.demo@squareup.com",
                       biography: "Engineer on the Point of Sale team.",
                       photoUrlSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                       photoUrlLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                       team: "Point of Sale",
                       employeeType: "FULL_TIME")
    }
}
