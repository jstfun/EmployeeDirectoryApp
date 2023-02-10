//
//  String+Extension.swift
//  EmployeeDirectory
//
//  Created by hope on 2/9/23.
//

import Foundation
import CryptoKit

extension String {
    var hashString: String {
        SHA256.hash(data: Data(self.utf8))
            .compactMap { String(format: "%02x", $0) }
            .joined()
    }
}
