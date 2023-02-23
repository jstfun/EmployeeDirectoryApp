//
//  EmployeeView.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import SwiftUI

struct EmployeeView: View {
    @ObservedObject var viewModel: EmployeeListViewModel
    @State private var photoImage: Data?
    let employee: EmployeeModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(data: photoImage)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.gray.opacity(0.6))
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                
                Text(employee.fullName)
                    .font(.system(size: 28))
            }
            
            Text(employee.employeeType?.description ?? "")
            
            Text(employee.biography ?? "")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .task {
            photoImage = await viewModel.getImage(for: employee.photoUrlSmall)
        }
    }
}

struct EmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeView(viewModel: EmployeeListViewModel(),
                         employee: EmployeeModel.example)
    }
}
