//
//  MockHTTPClient.swift
//  MyTimeTests
//
//  Created by hope on 2/9/23.
//

import Foundation
@testable import EmployeeDirectory

final class MockHTTPClient: URLSessionHTTPClient {
    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        super.init(urlSession: URLSession(configuration: configuration))
    }
}
