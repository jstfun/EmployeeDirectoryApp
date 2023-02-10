//
//  XCTestCase+Extension.swift
//  EmployeeDirectoryTests
//
//  Created by hope on 2/9/23.
//

import Foundation
import XCTest

extension XCTestCase {
    func assert<T, E>(
        _ expression: @autoclosure () throws -> T,
        throws error: E,
        in file: StaticString = #file,
        line: UInt = #line
    ) where E: Error & Equatable {
        var thrownError: Error?
        
        XCTAssertThrowsError(try expression(),
                             file: file, line: line) {
            thrownError = $0
        }
        XCTAssertTrue(
            thrownError is E,
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )
        XCTAssertEqual(
            thrownError as? E, error,
            file: file, line: line
        )
    }
    
    func assertAsync<T, E>(
        _ expression: @autoclosure () async throws -> T,
        throws errorThrown: E,
        message: @autoclosure () -> String = "This method should fail",
        file: StaticString = #filePath,
        line: UInt = #line
    ) async where E: Error & Equatable {
        do {
            let _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            XCTAssertEqual(error as? E, errorThrown)
        }
    }
}
