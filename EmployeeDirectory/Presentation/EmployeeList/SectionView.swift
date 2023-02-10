//
//  SectionView.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import SwiftUI

struct SectionView: View {
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(height: 42)
            .overlay(
                HStack {
                    Text(title)
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
                .padding()
            )
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "Section")
    }
}
