//
//  View+Extension.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func visible(_ status: Bool) -> some View {
        switch status {
        case true: self
        case false: self.hidden()
        }
    }
}
