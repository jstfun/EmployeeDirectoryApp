//
//  MockAPIService.swift
//  MyTimeTests
//
//  Created by hope on 2/9/23.
//

import Foundation
@testable import EmployeeDirectory

class MockAPIService: APIClient {
    init() {
        super.init(httpClient: MockHTTPClient())
    }
}
