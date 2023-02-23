//
//  EmployeeDetailViewModel.swift
//  EmployeeDirectory
//
//  Created by hope on 2/22/23.
//

import Foundation

final class EmployeeDetailViewModel: ObservableObject {
    @Published var photoData: Data?
    private let employee: EmployeeModel
    private let getImageUseCase: GetImageUseCase
    
    var fullName: String {
        employee.fullName
    }
    
    var phoneNumber: String {
        employee.phoneNumber ?? ""
    }
    
    var emailAddress: String {
        employee.emailAddress
    }
    
    var biography: String {
        employee.biography ?? ""
    }
    
    var team: String {
        employee.team?.rawValue ?? ""
    }
    
    var employeeType: String {
        employee.employeeType?.description ?? ""
    }
    
    init(_ employee: EmployeeModel, getImageUseCase: GetImageUseCase = GetImageUseCase()) {
        self.employee = employee
        self.getImageUseCase = getImageUseCase
    }
    
    @MainActor
    func loadPhotoImage() async {
        guard let urlString = employee.photoUrlLarge, let photoURL = URL(string: urlString) else {
            photoData = nil
            return
        }
        
        photoData = await getImageUseCase.execute(for: photoURL)
    }
}
