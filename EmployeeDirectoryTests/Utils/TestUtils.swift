//
//  TestUtils.swift
//  EmployeeDirectoryTests
//
//  Created by hope on 2/9/23.
//

import Foundation
@testable import EmployeeDirectory

func loadJSONEncoded(bundle: Bundle, file: String) -> Data {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let json = try? bundle.decode(EmployeesDTO.self,from: file,
                                  decoder: decoder)
    
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    
    do {
        let encoded = try encoder.encode(json)
        return encoded
    } catch {
        fatalError("Couldn't encode mock json data")
    }
}
