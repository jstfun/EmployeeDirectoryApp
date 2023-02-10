//
//  Image+Extension.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation
import SwiftUI

extension Image {
    init(data: Data?, placeholder: String = "person.circle.fill") {
        guard let data = data, let uiImage = UIImage(data: data) else {
            self = Image(systemName: placeholder)
            return
        }
        self = Image(uiImage: uiImage)
    }
}
