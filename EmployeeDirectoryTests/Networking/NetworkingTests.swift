//
//  NetworkingTests.swift
//  MyTimeTests
//
//  Created by hope on 2/9/23.
//

import XCTest
@testable import EmployeeDirectory

final class NetworkingTests: XCTestCase {
    private let apiService = MockAPIService()
    
    
    
    private func createHTTPResponse(url: String, statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: url)!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)!
    }
    
    func testGetEmployees_WhenNetworkError_ShouldGetURLSessionError() async {
        MockURLProtocol.requestHandler = { _ in
            throw NSError(domain: "URLSession error", code: 1000)
        }
        
        let response = await apiService.getEmployees()
        assert(try response.get(), throws: NetworkError.dispatchError)
    }
     
    func testGetEmployees_When404HTTPResponse_ShouldGetInvalidResponseError() async {
        let mockResponse = createHTTPResponse(url: "https://google.com", statusCode: 404)
        
        MockURLProtocol.requestHandler = { _ in (mockResponse, Data()) }
        
        let response = await apiService.getEmployees()
        assert(try response.get(), throws: NetworkError.invalidHttpStatus(404))
    }
    
    func testGetEmployees_WhenInvalidData_ShouldGetDecodingError() async {
        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), Data()) }
        
        let response = await apiService.getEmployees()
        assert(try response.get(), throws: NetworkError.decodingError)
    }
    
    func testGetEmployees_WhenMalformedResponse_ShouldRaiseDecodingError() async {
        let encoded = loadJSONEncoded(bundle: Bundle(for: type(of: self).self),
                                      file: "employees_malformed.json")
        MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), encoded) }
        let response = await apiService.getEmployees()
        
        assert(try response.get().employees, throws: NetworkError.decodingError)
    }
    
    func testGetEmployees_WhenValidResponse_ShouldValidEmployees() async {
        var errorThrown: Error?
        var employees: [EmployeeEntity] = []
        
        do {
            let encoded = loadJSONEncoded(bundle: Bundle(for: type(of: self).self),
                                          file: "employees.json")
            MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), encoded) }
            let response = await apiService.getEmployees()
            employees = try response.get().employees
        } catch {
            errorThrown = error
        }
        
        XCTAssertNil(errorThrown, "Expected no errors thrown")
        XCTAssertEqual(employees.count, 11, "Expected 11 employees")
    }
    
    func testGetEmployees_WhenEmptyResponse_ShouldEmptyEmployees() async {
        var errorThrown: Error?
        var employees: [EmployeeEntity] = []
        
        do {
            let encoded = loadJSONEncoded(bundle: Bundle(for: type(of: self).self),
                                          file: "employees_empty.json")
            MockURLProtocol.requestHandler = { _ in (HTTPURLResponse(), encoded) }
            let response = await apiService.getEmployees()
            employees = try response.get().employees
        } catch {
            errorThrown = error
        }
        
        XCTAssertNil(errorThrown, "Expected no errors thrown")
        XCTAssertEqual(employees.count, 0, "Expected empty employees")
    }
}
