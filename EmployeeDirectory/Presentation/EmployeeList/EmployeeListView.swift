//
//  EmployeeListView.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import SwiftUI

struct EmployeeListView: View {
    @StateObject var viewModel = EmployeeListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    employeeListView
                }
                .refreshable {
                    loadEmployeesData()
                }
                .alert(isPresented: $viewModel.showAlert) {
                    alertView
                }
                
                LoadingView(scaleSize: 1.6)
                    .visible(viewModel.showLoading)
            }
            .navigationTitle(viewModel.pageTitle)
        }
        .task {
            loadEmployeesData()
        }
    }
    
    var employeeListView: some View {
        LazyVStack(pinnedViews: .sectionHeaders) {
            ForEach(viewModel.teamEmployeesList, id: \.self) { teamEmployees in
                Section(header: SectionView(title: teamEmployees.team.rawValue)) {
                    ForEach(teamEmployees.employees, id: \.self) { employee in
                        EmployeeView(viewModel: viewModel,
                                     employee: employee)
                    }
                }
            }
        }
    }
    
    var alertView: Alert {
        Alert(
            title: Text(viewModel.alertTitle),
            message: Text(viewModel.alertMessage),
            dismissButton: .default(Text(viewModel.alertButtonText), action: {
                Task {
                    await viewModel.handleAlertAction()
                }
            })
        )
    }
    
    private func loadEmployeesData() {
        Task {
            await viewModel.getEmployees()
        }
    }
}

struct EmployeeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeListView()
    }
}
