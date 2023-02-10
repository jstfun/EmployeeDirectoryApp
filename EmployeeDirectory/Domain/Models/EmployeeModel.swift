//
//  EmployeeModel.swift
//  EmployeeDirectory
//
//  Created by hope on 2/8/23.
//

import Foundation

enum EmployeeType: String {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
    
    var description: String {
        switch self {
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        case .contractor:
            return "Contractor"
        }
    }
}

enum TeamType: String {
    case core = "Core"
    case hardware = "Hardware"
    case salesPlatform = "Point of Sale Platform"
    case sales = "Point of Sale"
    case invoices = "Invoices"
    case appointments = "Appointments"
    case cash = "Cash"
    case restaurants = "Restaurants"
    case retail = "Retail"
    case webMarketing = "Public Web & Marketing"
}

struct EmployeeModel: Hashable {
    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: TeamType?
    let employeeType: EmployeeType?
    
    init(from entity: EmployeeEntity) {
        uuid = entity.uuid
        fullName = entity.fullName
        phoneNumber = entity.phoneNumber
        emailAddress = entity.emailAddress
        biography = entity.biography
        photoUrlSmall = entity.photoUrlSmall
        photoUrlLarge = entity.photoUrlLarge
        team = TeamType(rawValue: entity.team)
        employeeType = EmployeeType(rawValue: entity.employeeType)
    }
}

extension EmployeeModel {
    static var example: Self {
        EmployeeModel(from: EmployeeEntity.exmple)
    }
}
