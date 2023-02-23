//
//  EmployeeDetailView.swift
//  EmployeeDirectory
//
//  Created by hope on 2/22/23.
//

import SwiftUI

enum ContactType: String {
    case email = "envelope"
    case phone = "phone"
}

struct EmployeeDetailView: View {
    @ObservedObject var viewModel: EmployeeDetailViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                profileImageView()
                    .cornerRadius(8)
                
                Text(viewModel.fullName)
                    .font(.title)
                
                Text(viewModel.biography)
                    .font(.body)
                
                Divider()
                
                Text("**Contact Information**")
                
                contactRowView(type: .phone, info: viewModel.phoneNumber)
                    .padding(.top, 4)
                
                contactRowView(type: .email, info: viewModel.emailAddress)
                    .padding(.top, 4)
                
                informationRowView()
            }
            .padding()
        }
        .task {
            await viewModel.loadPhotoImage()
        }
    }
    
    private func profileImageView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.gray.opacity(0.1))
            
            Image(data: viewModel.photoData)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray.opacity(0.1))
        }
    }
    
    private func contactRowView(type: ContactType, info value: String) -> some View {
        Button {
            handleContact(type)
        } label: {
            HStack {
                Image(systemName: type.rawValue)
                
                Text(value)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 32)
        .buttonStyle(PlainButtonStyle())
        
    }
    
    private func informationRowView() -> some View {
        VStack(alignment: .leading) {
            Divider()
            
            Text("**Team** : \(viewModel.team)")
            
            Spacer(minLength: 8)
            
            Text("**Employment Type**: \(viewModel.employeeType)")
            
            Spacer(minLength: 16)
        }
    }
    
    private func handleContact(_ type: ContactType) {
        // Handle contact
    }
}

struct EmployeeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDetailView(viewModel: EmployeeDetailViewModel(EmployeeModel.example))
    }
}
