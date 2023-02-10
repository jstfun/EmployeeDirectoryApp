//
//  EmployeeListViewModel.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation

final class EmployeeListViewModel: ObservableObject {
    @Published var showLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var teamEmployeesList: [TeamEmployeesModel] = []
    
    private(set) var pageTitle = "Employees"
    private(set) var alertTitle = ""
    private(set) var alertMessage = ""
    private(set) var alertButtonText = ""
    
    private let getEmployeesUseCase: GetEmployeesUseCase
    private let getImageUseCase: GetImageUseCase
    
    init(getEmployeesUseCase: GetEmployeesUseCase = GetEmployeesUseCase(),
         getImageUseCase: GetImageUseCase = GetImageUseCase()) {
        self.getEmployeesUseCase = getEmployeesUseCase
        self.getImageUseCase = getImageUseCase
    }
    
    @MainActor
    func getEmployees() async {
        if showLoading { return }
        
        showLoading = true
        do {
            let employees = try await getEmployeesUseCase.execute().filter { $0.team != nil }
            
            // Grouping employees by the team and
            // sorting employees by their full name alphabetically.
            teamEmployeesList = Dictionary(grouping: employees, by: \.team)
                .map { (team, employees) in
                    TeamEmployeesModel(team: team!,
                                       employees: employees.sorted { $0.fullName < $1.fullName })
                }
                .sorted { $0.team.rawValue < $1.team.rawValue }
            
            showLoading.toggle()
        } catch {
            showLoading.toggle()
            showAlert = true
            alertTitle = AppMessage.error
            alertButtonText = AppMessage.retry
            alertMessage = AppMessage.failedLoadingEmployees
        }
    }
    
    func getImage(for urlString: String?) async -> Data? {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return nil
        }
        
        return await getImageUseCase.execute(for: url)
    }
    
    func handleAlertAction() async {
        if alertButtonText == AppMessage.retry &&
            alertMessage == AppMessage.failedLoadingEmployees {
            await getEmployees()
            return
        }
        
        showAlert = false
    }
}

